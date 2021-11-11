# How to build a simple blog with rich text editor

### _This document have instructions to create, update and delete posts with rich text and have actions: like and dislike_

We will create an application using rails 6 with bootstrap, rich text editor and hotwire (it's default in rails 7!). So, will have real-time opperations.

- yarn
- rvm with **ruby 2.7.2**
- Rails 6
  - Faker data to seeds
- Bootstrap
  - Bootstrap form too
- Rich Text Editor
  - With Active Storage
- Hotwire-rails
- Solargraph to help me to code better

## Steps

- Create simple application without tests (maybe we can test using rspec later)
- Create **Post** with: **title**, **content**, **likes** and **dislikes**
- Form with **rich text editor** and with this we can put styles in the **content**, drag and drop images...
- **Likes** and **Dislikes** count with action in real-time
- Preppend the **Posts** list with new **Post**
- **Edit** and **Remove** the **Post** from **Posts** list

## Setup the base of application

Create the application with rails 6 and ruby 2.7.2 using rvm

```
rvm use 2.7.2@simple_blog --create
gem install rails --no-doc
rails new simple_blog -T --no-doc
cd simple_blog
touch .ruby-gemset
echo "simple_blog" >> .ruby-gemset
echo ".ruby-gemset" >> .gitignore
rvm @global do gem install solargraph --no-doc
rvm 2.7.2@global do gem install solargraph --no-doc
cd .
bundle add image_processing
bundle
yarn
rails active_storage:install
rails db:drop db:create db:migrate
rails s
```

## Applying styles, layout for Post CRUD with faker data

With **bootstrap** and moving _partials_, changing _post lists_, the result will be one page with all possible actions to **CRUD POST** and **Like and Dislike** too for each one.

- Create **Post** CRUD
- Add faker data
- Unify **Post Form** and **Posts List** to root page

In the console, inside the application folder run

```
rails g scaffold Post title content:text likes_view:integer dislikes_view:integer
rails db:migrate
rm app/assets/stylesheets/*.scss
bundle add faker
bundle add bootstrap_form
bundle
```

Add faker data with seeds. Put inside the db/seeds.rb

```ruby
require 'faker'
20.times.each do
  Post.create!(title: Faker::Book.title, content: Faker::Lorem.sentence)
end
```

And in `application.css`

```css
*= require rails_bootstrap_forms
```

Create a **Post** example list

```
rails db:seed
```

Format the `posts/index.html.erb` with partial `posts/_form.html.erb` and the list with `posts/_post.html.erb`, we will not use the table. The **Post list** will have the `edit, destroy, like and dislike` actions. Put root of the application to `posts#index` in the `config/routes.rb`

```
root to: 'posts#index'
```

In the `application.html.erb` add **bootstrap** tags and format using styles

```html
<link
  rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
  integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
  crossorigin="anonymous"
/>

<!--before closing tag <body> element-->

<script
  src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
  integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
  crossorigin="anonymous"
></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
  integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
  crossorigin="anonymous"
></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
  integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
  crossorigin="anonymous"
></script>
```

Apply styles, html codes and actions in the `posts/index.html.erb, posts/_posts.html.erb` and so important, use `rails_bootstrap_forms` in `posts/_form.html.erb`

Now it's time to add `rich_text_area` with `trix editor`

```
rails action_text:install
rails db:migrate
yarn
```

Inside the `application.js`

```
import "trix"
import "@rails/actiontext"
```

Add `has_rich_text` in `content` attribute inside at `Post` model

```
has_rich_text :content
```

Refact the `posts/_form.html.erb` to use `rich_text_area`

```erb
form.rich_text_area
```

And refact `posts/_post.html.erb` to receive format that **trix editor** make to your content

```erb
<div class="trix-content"><%=post.content%></div>
```

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is \*actually- written in Markdown! To get a feel
for Markdown's syntax, type some text into the left window and
watch the results in the right.

## Tech

Dillinger uses a number of open source projects to work properly:

- [AngularJS] - HTML enhanced for web apps!
- [Ace Editor] - awesome web-based text editor
- [markdown-it] - Markdown parser done right. Fast and easy to extend.
- [Twitter Bootstrap] - great UI boilerplate for modern web apps
- [node.js] - evented I/O for the backend
- [Express] - fast node.js network app framework [@tjholowaychuk]
- [Gulp] - the streaming build system
- [Breakdance](https://breakdance.github.io/breakdance/) - HTML
  to Markdown converter
- [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
on GitHub.

## Installation

Dillinger requires [Node.js](https://nodejs.org/) v10+ to run.

Install the dependencies and devDependencies and start the server.

```sh
cd dillinger
npm i
node app
```

For production environments...

```sh
npm install --production
NODE_ENV=production node app
```

## Plugins

Dillinger is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin           | README                                    |
| ---------------- | ----------------------------------------- |
| Dropbox          | [plugins/dropbox/README.md][pldb]         |
| GitHub           | [plugins/github/README.md][plgh]          |
| Google Drive     | [plugins/googledrive/README.md][plgd]     |
| OneDrive         | [plugins/onedrive/README.md][plod]        |
| Medium           | [plugins/medium/README.md][plme]          |
| Google Analytics | [plugins/googleanalytics/README.md][plga] |

## Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantaneously see your updates!

Open your favorite Terminal and run these commands.

First Tab:

```sh
node app
```

Second Tab:

```sh
gulp watch
```

(optional) Third:

```sh
karma test
```

#### Building for source

For production release:

```sh
gulp build --prod
```

Generating pre-built zip archives for distribution:

```sh
gulp build dist --prod
```

## Docker

Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

```sh
cd dillinger
docker build -t <youruser>/dillinger:${package.json.version} .
```

This will create the dillinger image and pull in the necessary dependencies.
Be sure to swap out `${package.json.version}` with the actual
version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart=always --cap-add=SYS_ADMIN --name=dillinger <youruser>/dillinger:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

## License

MIT

**Free Software, Hell Yeah!**

[//]: # "These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax"
[dill]: https://github.com/joemccann/dillinger
[git-repo-url]: https://github.com/joemccann/dillinger.git
[john gruber]: http://daringfireball.net
[df1]: http://daringfireball.net/projects/markdown/
[markdown-it]: https://github.com/markdown-it/markdown-it
[ace editor]: http://ace.ajax.org
[node.js]: http://nodejs.org
[twitter bootstrap]: http://twitter.github.com/bootstrap/
[jquery]: http://jquery.com
[@tjholowaychuk]: http://twitter.com/tjholowaychuk
[express]: http://expressjs.com
[angularjs]: http://angularjs.org
[gulp]: http://gulpjs.com
[pldb]: https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md
[plgh]: https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md
[plgd]: https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md
[plod]: https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md
[plme]: https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md
[plga]: https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md
