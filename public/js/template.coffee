define ['underscore'],(_)->
  {
  load: (name, req, onload, config)->
    req(["text!#{name}.template"],  (value) ->
      onload(_.template(value))
    )
  }

