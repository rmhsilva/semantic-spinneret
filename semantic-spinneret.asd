;;;; Semantic Spinneret

(asdf:defsystem :semantic-spinneret
  :version      "0.1.0"
  :description  "A set of Semantic UI components for use with Spinneret"
  :author       "Ric da Silva <ric@rmhsilva.com>"
  :license      "MIT"
  :depends-on   (#:alexandria
                 #:spinneret)
  :serial t
  :components   ((:file "components")))
