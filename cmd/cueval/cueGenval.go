package cueval

import (
	"io"
	"io/fs"
	"os"
	"path/filepath"

	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	embeder "github.com/intelops/genval"
	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: false,
		FieldMap: log.FieldMap{
			log.FieldKeyTime:  "@timestamp",
			log.FieldKeyLevel: "@level",
			log.FieldKeyMsg:   "@message",
		},
	})
}

func Execute(args []string) {

	staticFS := embeder.CueDef

	td, err := os.MkdirTemp("", "")
	if err != nil {
		log.Fatal(err)
	}
	defer os.RemoveAll(td)

	overlay := make(map[string]load.Source)
	err = fs.WalkDir(staticFS, ".", func(p string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !d.Type().IsRegular() {
			return nil
		}
		f, err := staticFS.Open(p)
		if err != nil {
			return err
		}
		byts, err := io.ReadAll(f)
		if err != nil {
			return err
		}
		op := filepath.Join(td, p)
		overlay[op] = load.FromBytes(byts)
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}

	config := &load.Config{
		Overlay: overlay,
		Dir:     td,
	}
	inst := load.Instances([]string{"github.com/intelops/genval/schema:kubernetes"}, config)
	if err != nil {
		log.Fatal(err)
	}
	ctx := cuecontext.New()
	v, err := ctx.BuildInstances(inst)
	if err != nil {
		log.Errorf("Could not build Instances from %v: %v", v, err)
	}
	log.Printf("%v\n", v)

}
