+++
math = false
date = "2017-02-13T12:54:27+08:00"
title = "Deploy Hugo-Academic on Github Pages"
tags = ['hugo', 'news']
highlight = true

[header]
  caption = ""
  image = ""

+++

I tried to move from jekyll to hugo to enhance my personal website. But I still want to use Github Pages to host the generated html files (in the `Public` folder). The trick is you have to move the files in the `Public` folder to the local folder of your github folder.

- Create on GitHub `mywebsite-hugo` repository (it will host Hugo’s content)
- Create on GitHub `chengjun.github.io` repository (it will host the public folder: the static website)
- `cd github`
- `git clone https://github.com/chengjun/mywebsite-hugo.git`
- `hugo new site mywebsite-hugo --force`
- `cd mywebsite-hugo`
-  download [Academic](https://github.com/gcushen/hugo-academic/archive/master.zip) and extract it into a themes/academic folder within your Hugo website.
- If you are creating a new website, copy the contents of the exampleSite folder to your website root folder, overwriting existing files if necessary.
- Manage the content and `hugo server --watch`
- Once you are happy with the results, `Ctrl+C` (kill server)
- Almost done: add a `deploy.sh` script to help you (see the following script)
- and make it executable: `chmod +x deploy.sh`
- `./deploy.sh "Your optional commit message"` to send changes to <username>.github.io
- (careful, you may also want to commit changes on the <your-project>-hugo repo).

The following script is content of the deploy.sh.

```bash
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd ..

cd chengjun.github.io

cp -av /Users/chengjun/github/mywebsite-hugo/public/* .


# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..
```

Each time when I want to add some files, I can easily do it using atom and terminal. for exmaple, add a markdown file to the post, I can simply run `hugo new post/example.md` in my terminal, and then edit it using atom.

I can inspect the effect by running `hugo server --watch`

## deploying the html files

After I make some changes, I can conveniently run the following code to deploy the html files to github pages.

{{% alert note %}}
`./deploy.sh "Your optional commit message"`
{{% /alert %}}

For the source code in the mywebsite-hugo folder, I can also easily archive them within Atom using the 'Git Plus' package.

## Update

There is another way to avoid opening a terminal by using the Script package.

- install the `Script` package of Atom,
- open the deploy.sh within Atom
- press `Ctrl + I`
