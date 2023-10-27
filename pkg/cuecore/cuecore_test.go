package cuecore

import (
	"reflect"
	"testing"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

func TestBuildInstance(t *testing.T) {
	ctx := cuecontext.New()

	tests := []struct {
		name     string
		policies []string
		conf     *load.Config
		wantErr  bool
	}{
		{
			name:     "valid policies",
			policies: []string{"./testdata/test.cue"},
			conf:     &load.Config{},
			wantErr:  false,
		},
		{
			name:     "no policies",
			policies: []string{},
			conf:     &load.Config{},
			wantErr:  true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := BuildInstance(ctx, tt.policies, tt.conf)
			if (err != nil) != tt.wantErr {
				t.Errorf("BuildInstance() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}

func TestUnifyAndValidate(t *testing.T) {
	ctx := cuecontext.New()

	def := ctx.CompileString(`{name: string, age: int}`)
	validData := ctx.CompileString(`{name: "John", age: 25}`)
	invalidData := ctx.CompileString(`{name: 123, age: "25"}`)

	tests := []struct {
		name    string
		def     cue.Value
		data    cue.Value
		wantErr bool
	}{
		{
			name:    "valid data",
			def:     def.Value(),
			data:    validData.Value(),
			wantErr: false,
		},
		{
			name:    "invalid data",
			def:     def.Value(),
			data:    invalidData.Value(),
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := UnifyAndValidate(tt.def, tt.data)
			if (err != nil) != tt.wantErr {
				t.Errorf("UnifyAndValidate() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}

func TestMarshalToYAML(t *testing.T) {
	ctx := cuecontext.New()

	value := ctx.CompileString(`{name: "John", age: 25}`)

	tests := []struct {
		name    string
		value   cue.Value
		want    []byte
		wantErr bool
	}{
		{
			name:    "valid value",
			value:   value.Value(),
			want:    []byte("age: 25\nname: John\n"),
			wantErr: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := MarshalToYAML(tt.value)
			if (err != nil) != tt.wantErr {
				t.Errorf("MarshalToYAML() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("MarshalToYAML() = %v, want %v", got, tt.want)
			}
		})
	}
}
