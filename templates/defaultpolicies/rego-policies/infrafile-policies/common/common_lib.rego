package k8s.common

import future.keywords.in


valid_key(obj, key) {
	_ = obj[key]
	not is_null(obj[key])
} else = false {
	true
}