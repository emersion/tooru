# tooru

Archive and sync content you want to see twice.

Inspired from one of [@SirCmpwn](https://github.com/SirCmpwn)'s articles : http://sircmpwn.github.io/2017/06/19/Archive-it-or-miss-it.html

## Usage

Create a file named `sources` with one link per line and run `tooru`:

```bash
mkdir ~/archives
cd ~/archives
echo "https://drewdevault.com" >> sources
tooru
```

You can setup a cronjob to sync your archive periodically:

```
0 0 * * 0 cd ~/archives && tooru
```

## Supported content

* Everything that `youtube-dl` supports
* Falls back to `wget`

## License

MIT
