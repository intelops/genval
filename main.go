package main

import (
	"flag"
	"fmt"
	"os"
	"runtime"
	"runtime/pprof"

	log "github.com/sirupsen/logrus"

	"github.com/intelops/genval/cmd"
)

var (
	cpuprofile = os.Getenv("CPUPROFILE")
	memprofile = os.Getenv("MEMPROFILE")
)

func main() {
	flag.Parse()
	if cpuprofile != "" {
		pprofF, err := os.Create("cpu.pprof")
		fmt.Printf("Created CPUProfile file: %v", pprofF)
		if err != nil {
			log.Fatal("could not start CPU profile: ", err)
		}
		defer pprofF.Close()
		if err := pprof.StartCPUProfile(pprofF); err != nil {
			log.Fatal("could not start CPU profile: ", err)
		}
		defer pprof.StopCPUProfile()
	}
	if memprofile != "" {
		mempprof, err := os.Create("mem.pprof")
		if err != nil {
			log.Fatal("could not create memory profile: ", err)
		}
		runtime.GC()
		if err := pprof.WriteHeapProfile(mempprof); err != nil {
			log.Fatal("could not write memory profile: ", err)
		}
		defer mempprof.Close()

	}
	cmd.Execute()
}
