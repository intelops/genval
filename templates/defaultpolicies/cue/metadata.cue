package foo

#Metadata: {
	name:      *"genval" | string
	namespace: *"genval" | string
	labels: {
		app: string | *"genval"
		env: *"mytest" | string
	}
	...
}
