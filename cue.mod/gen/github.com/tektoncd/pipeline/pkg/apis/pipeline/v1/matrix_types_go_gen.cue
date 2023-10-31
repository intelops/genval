// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/pipeline/v1

package v1

// Matrix is used to fan out Tasks in a Pipeline
#Matrix: {
	// Params is a list of parameters used to fan out the pipelineTask
	// Params takes only `Parameters` of type `"array"`
	// Each array element is supplied to the `PipelineTask` by substituting `params` of type `"string"` in the underlying `Task`.
	// The names of the `params` in the `Matrix` must match the names of the `params` in the underlying `Task` that they will be substituting.
	// +listType=atomic
	params?: #Params @go(Params)

	// Include is a list of IncludeParams which allows passing in specific combinations of Parameters into the Matrix.
	// +optional
	// +listType=atomic
	include?: #IncludeParamsList @go(Include)
}

// IncludeParamsList is a list of IncludeParams which allows passing in specific combinations of Parameters into the Matrix.
#IncludeParamsList: [...#IncludeParams]

// IncludeParams allows passing in a specific combinations of Parameters into the Matrix.
#IncludeParams: {
	// Name the specified combination
	name?: string @go(Name)

	// Params takes only `Parameters` of type `"string"`
	// The names of the `params` must match the names of the `params` in the underlying `Task`
	// +listType=atomic
	params?: #Params @go(Params)
}

// Combination is a map, mainly defined to hold a single combination from a Matrix with key as param.Name and value as param.Value
#Combination: {[string]: string}

// Combinations is a Combination list
#Combinations: [...#Combination]
