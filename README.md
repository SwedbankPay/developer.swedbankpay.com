# developer.swedbankpay.com

[![Swedbank Pay Developer Portal][dev-portal-image]][dev-portal]

[![GitHub Actions Status][gh-actions-badge]][gh-actions]
![Last Master Commit][last-commit-badge]

This is the repository for [Swedbank Pay Developer Portal][1]. It is run as a
[Jekyll][2] website on [GitHub Pages][3].

## Usage

To view this website, browse to [developer.swedbankpay.com][1]. If you'd like
to host it locally on your computer, you need to do the following:

1. [Clone this repository][4].
2. Jekyll is written in [Ruby][5], so you'll need to download and install that.
   If you're installing on Windows, choose setup with DevKit.
3. To install the [Ruby Gems][6] this web site requires, you first need to
   install [Bundler][7].
4. Once Ruby and Bundler is in place, type `bundle install` inside the root
   folder of this repository.
5. Run `bundle exec jekyll serve` to start the website.
6. Open `http://localhost:4000` in a browser.
7. In Visual Studio Code, install the following plugins:
   * `davidanson.vscode-markdownlint`
   * `shd101wyy.markdown-preview-enhanced`
   * `bpruitt-goddard.mermaid-markdown-syntax-highlighting`

## Contributing

Bug reports and pull requests are welcome on [GitHub][8]. This project is
intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant][9] code of conduct as
well as [PayEx Open Source Development Guidelines][10].

## License

This website is available as open source under the terms of the
[MIT License][11].

[1]: https://developer.swedbankpay.com
[2]: https://jekyllrb.com/
[3]: https://pages.github.com/
[4]: https://help.github.com/articles/cloning-a-repository/
[5]: https://www.ruby-lang.org/en/
[6]: https://rubygems.org/
[7]: https://bundler.io/
[8]: https://github.com/SwedbankPay/developer.swedbankpay.com/
[9]: http://contributor-covenant.org
[10]: https://developer.payex.com/xwiki/wiki/developer/view/Main/guidelines/open-source-development-guidelines/
[11]: https://opensource.org/licenses/MIT
[dev-portal-image]: ./assets/img/swedbank-pay-developer-portal.png
[dev-portal]: https://developer.swedbankpay.com/
[gh-actions-badge]: https://github.com/SwedbankPay/developer.swedbankpay.com/workflows/jekyll-build/badge.svg
[gh-actions]: https://github.com/SwedbankPay/developer.swedbankpay.com/actions
[last-commit-badge]: https://img.shields.io/github/last-commit/SwedbankPay/developer.swedbankpay.com/master
