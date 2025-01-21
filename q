[1mdiff --git a/pkg/validate/regoval.go b/pkg/validate/regoval.go[m
[1mindex 4b08c5b..53186a3 100644[m
[1m--- a/pkg/validate/regoval.go[m
[1m+++ b/pkg/validate/regoval.go[m
[36m@@ -7,12 +7,13 @@[m [mimport ([m
 	"path/filepath"[m
 	"strings"[m
 [m
[1;35m-	"github.com/intelops/genval/pkg/oci"[m
[1;35m-	"github.com/intelops/genval/pkg/parser"[m
[1;35m-	"github.com/intelops/genval/pkg/utils"[m
 	"github.com/open-policy-agent/opa/ast"[m
 	"github.com/open-policy-agent/opa/rego"[m
 	log "github.com/sirupsen/logrus"[m
[32m+[m
[1;36m+[m	[1;36m"github.com/intelops/genval/pkg/oci"[m
[1;36m+[m	[1;36m"github.com/intelops/genval/pkg/parser"[m
[1;36m+[m	[1;36m"github.com/intelops/genval/pkg/utils"[m
 )[m
 [m
 type InputProcessor interface {[m
[36m@@ -43,6 +44,7 @@[m [mfunc (g GenericProcessor) ProcessInput(content string) ([]byte, error) {[m
 	}[m
 	return jsonData, nil[m
 }[m
[32m+[m
 func ValidateWithRego(inputContent, regoPolicyPath string, processor InputProcessor) error {[m
 	metaFiles, regoPolicy, err := FetchRegoMetadata(regoPolicyPath, metaExt, policyExt)[m
 	if err != nil {[m
[1mdiff --git a/templates/inputs/cue/combined/deploy.json b/templates/inputs/cue/combined/deploy.json[m
[1mindex 3ae53af..c3697e5 100644[m
[1m--- a/templates/inputs/cue/combined/deploy.json[m
[1m+++ b/templates/inputs/cue/combined/deploy.json[m
[36m@@ -24,7 +24,7 @@[m
         "containers": [[m
           {[m
             "name": "website",[m
[31m-            "image": "nginx:1.20",[m
[32m+[m[32m            "image": "nginx:1.21",[m
             "imagePullPolicy": "Always",[m
             "ports": [[m
               {[m
[36m@@ -53,4 +53,4 @@[m
       }[m
     }[m
   }[m
[31m-}[m
\ No newline at end of file[m
[32m+[m[32m}[m
