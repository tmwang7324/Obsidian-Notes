A local Supabase instance, under the hood, is containerized in [[Docker]]. To generate the image, run 
```bash
npx supabase init

```

This command creates a `supabase/` directory that contains `config.toml`, a `./temp` folder, and `.gitignore.`

The `config.toml` file contains the local machine Supabase configurations. To connect to a remotely hosted Supabase instance, there is no need to edit this file.

```bash
npx supabase login
npx supabase link <my-project-url>
npx supabase db push # since I already have my SQL migrations
```