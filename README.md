# developer.swedbankpay.com

[![Swedbank Pay Developer Portal][dev-portal-image]][dev-portal]

[![GitHub Actions Status][gh-actions-badge]][gh-actions]
![Last Master Commit][last-commit-badge]

This is the repository for [Swedbank Pay Developer Portal][swp-dp]. It is run as a
[Jekyll][jekyll] website on [GitHub Pages][gh-pages].

## Contributing

Bug reports and pull requests are welcome on [GitHub][github]. This project is
intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant][ccov] code of conduct as
well as [Swedbank Pay Open Source Development Guidelines][dev-guidelines].

## Usage

To view this website, browse to [developer.swedbankpay.com][swp-dp]. If you'd
like to host it locally on your computer, you need to do the following:

1. [Clone this repository][cloning].
2. Jekyll is written in [Ruby][ruby], so you'll need to download and install
   that. If you're installing on Windows, choose setup with DevKit.
3. To install the [Ruby Gems][gems] this web site requires, you first need to
   install [Bundler][bundler].
4. Once Ruby and Bundler is in place, type `bundle install` inside the root
   folder of this repository.
5. Run `bundle exec jekyll serve` to start the website.
6. Open `http://localhost:4000` in a browser.
7. In Visual Studio Code, install the following plugins:
   * `davidanson.vscode-markdownlint`, to lint Markdown files according to an
     defined set of rules.
   * `shd101wyy.markdown-preview-enhanced`, to render Markdown to HTML in a
     preview window.
   * `bpruitt-goddard.mermaid-markdown-syntax-highlighting`, to give syntax
     highlighting Mermaid diagrams in Markdown files.
   * `yzhang.markdown-all-in-one`, to enable a plethora of Markdown features,
     most importantly formatting of Markdown tables with VS Code's built-in
     format functionality.
   * `stkb.rewrap`, to make line-breaking text at 80 characters easier.
8. Also in Visual Studio Code, [set up a ruler at 80 characters][vsc-ruler]
   by adding `"editor.rulers": [80]` to its configuration.

## License

This website is available as open source under the terms of the
[MIT License][license].

[bundler]: https://bundler.io/
[ccov]: http://contributor-covenant.org
[cloning]: https://help.github.com/articles/cloning-a-repository/
[dev-guidelines]: https://developer.swedbankpay.com/resources/development-guidelines
[dev-portal-image]: ./assets/img/swedbank-pay-developer-portal.png
[dev-portal]: https://developer.swedbankpay.com/
[gems]: https://rubygems.org/
[gh-actions-badge]: https://github.com/SwedbankPay/developer.swedbankpay.com/workflows/jekyll-build/badge.svg
[gh-actions]: https://github.com/SwedbankPay/developer.swedbankpay.com/actions
[gh-pages]: https://pages.github.com/
[github]: https://github.com/SwedbankPay/developer.swedbankpay.com/
[jekyll]: https://jekyllrb.com/
[last-commit-badge]: https://img.shields.io/github/last-commit/SwedbankPay/developer.swedbankpay.com/master
[license]: https://opensource.org/licenses/MIT
[ruby]: https://www.ruby-lang.org/en/
[swp-dp]: https://developer.swedbankpay.com
[vsc-ruler]: https://stackoverflow.com/a/29972073/61818
