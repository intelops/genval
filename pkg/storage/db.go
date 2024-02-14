package storage

import (
	"os"
	"sync"

	"github.com/intelops/genval/pkg/log"
	"github.com/sirupsen/logrus"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

const DB_FILENAME = "storage.db"

var db *gorm.DB
var err error
var o sync.Once
var logger *logrus.Logger

// InitDatabase initializes the database by opening a connection and removing the database file if it already exists.
// If any error occurs during the process, it logs the error and exits the program.
func InitDatabase() error {
	logger = log.GetLogger()
	o.Do(func() {
		if _, err = os.Stat(DB_FILENAME); err == nil {
			err = os.Remove(DB_FILENAME)
			if err != nil {
				logger.Debugf("Error removing database file: %v", err)
				os.Exit(1)
			}
		}
		db, err = gorm.Open(sqlite.Open(DB_FILENAME), &gorm.Config{})
		if err != nil {
			logger.Debugf("Error opening database: %v", err)
			os.Exit(1)
		}
	})
	return err
}

// GetDatabase retrieves the database connection
func GetDatabase() *gorm.DB {
	return db
}

// CloseDatabase closes the database connection if it is not nil
func CloseDatabase() {
	if db != nil {
		// Get the underlying SQLite connection
		SQLite, err := db.DB()
		if err != nil {
			logger.Debugf("Error getting SQLite connection: %v", err)
			// Close the SQLite connection
			SQLite.Close()
			os.Exit(1)
		}
	}
}
