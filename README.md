# Brecheret

[![Maintainability](https://api.codeclimate.com/v1/badges/befbeae88ae38fee9fdd/maintainability)](https://codeclimate.com/github/VAGAScom/brecheret/maintainability)

Brecheret let's you easily upload your static files to S3

## Usage

Let's suppose you have the folowing file structure:

```sh
❯ tree
.
└── files
    ├── bar_bucket
    │   └── some_image.jpg
    └── foo_bucket
        ├── baz_file.txt
        └── baz_folder
            └── another_file.jpg
```

To upload these files to S3 just run:
```sh
  docker run -v `echo "$(pwd)/files"`:/files  -e AWS_ACCESS_KEY_ID=MY@CC3SSK3Y -e AWS_SECRET_ACCESS_KEY=MYS3CR3TK3Y -e AWS_REGION=us-east-1 vagascom/brecheret upload
```

This will upload some_image.jpg to `bar_bucket` and baz_file.txt and all the files in baz_folder to the `foo_bucket`.

Alternatively if you want to only upload the files in `foo_bucket` run the folowing command:

```sh
  docker run -v `echo "$(pwd)/files"`:/files -e AWS_ACCESS_KEY_ID=MY@CC3SSK3Y -e AWS_SECRET_ACCESS_KEY=MYS3CR3TK3Y -e AWS_REGION=us-east-1  vagascom/brecheret foo_bucket:upload
```

### Filtering items

If you want to upload just some files you can specify a regexp, that way only files with a path matching the regexp will be uploaded.

So, to upload only SVG files you can run:

```sh
  docker run -v `echo "$(pwd)/files"`:/files -e AWS_ACCESS_KEY_ID=MY@CC3SSK3Y -e AWS_SECRET_ACCESS_KEY=MYS3CR3TK3Y -e AWS_REGION=us-east-1 -e FILTER_REGEXP='*.svg$' vagascom/brecheret upload
```

### Using with Docker Compose

You can also create a custom repository for your static files, then with a docker-compose file you can set a .env file and easily share your files in a volume like so:

```yaml
version: "3"

services:
  static_files:
    image: vagascom/brecheret
    command: "-T"
    env_file:
      - .env
    volumes:
      - ./files:/files
```

Then you can run `docker-compose run --rm static_files upload` to upload your files.

## TODO

1. Reduce Aws dependency if possible, only S3 related gems are necessary.
2. Implement an asynchronous upload
