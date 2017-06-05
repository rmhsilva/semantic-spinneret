;;;; Component definitions
(defpackage :semantic-spinneret
  (:nicknames :ss)
  (:use :cl)
  (:import-from :spinneret :deftag)
  (:export
   :checkbox
   :dropdown
   :field
   :table))

(in-package #:semantic-spinneret)


(deftag checkbox (extra attrs &key label value name)
  `(:div.ui.checkbox
    (:input.hidden :type "checkbox"
                   :name ,name
                   ,@attrs
     :checked ,(if value "checked" nil))
    (:label ,label)
    ,@extra))


(deftag field (extra attrs &key label div-classes)
  "A form field"
  `(:div.field :class ,div-classes
               ,(if label `(:label ,label))
               (:input ,@attrs)
               ,@extra))


(deftag dropdown (default attrs &key name placeholder value-pairs class)
  "A dropdown. `value-pairs' contains the data-value pairs"
  (let ((pair (gensym "PAIR")))
    (alexandria:once-only (name)
      `(:div.field
        (:div.ui.selection.dropdown
         :class ,class
         (:input :type "hidden"
                 :id ,name
                 :name ,name
                 ,@attrs
          :value (progn ,@default))
         (:i.dropdown.icon)
         (:div.default.text ,placeholder)
         (:div.menu (loop for ,pair in ,value-pairs
                          do (:div.item :data-value (car ,pair)
                                        (cdr ,pair)))))))))


(deftag table (rest attrs &key trs tds class)
  (alexandria:with-gensyms (current current-row current-col)
    `(:table.ui.table
      :class ,class
      ,@attrs
      (:thead (:tr (dolist (,current ,trs)
                     (:th ,current))))
      (:tbody
       (dolist (,current-row ,tds)
         (:tr (dolist (,current-col ,current-row)
                (:td ,current-col))))
       ,@rest))))
