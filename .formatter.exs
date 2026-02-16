[
  import_deps: [:ecto, :ecto_sql, :phoenix, :open_api_spex],
  subdirectories: ["priv/*/migrations"],
  inputs: [
    "*.{ex,exs}",
    "config/**/*.{ex,exs}",
    "{lib,test}/**/*.{ex,exs}",
    "priv/*/seeds.exs"
  ],
  plugins: [Recode.FormatterPlugin],
]
