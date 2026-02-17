[
  import_deps: [:phoenix, :oaskit],
  subdirectories: ["priv/*/migrations"],
  inputs: [
    "*.{ex,exs}",
    "config/**/*.{ex,exs}",
    "{lib,test}/**/*.{ex,exs}",
    "priv/*/seeds.exs"
  ]
]
