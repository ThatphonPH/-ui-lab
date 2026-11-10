# Automated UI testing lab

ITDS362, Week 11. The selected parts are **Part 3 (Robot Framework)** and **Part 4 (Cypress)**. Both automate QP-01 against QuickPizza and exercise the Selenium practice form. See [RESULTS.md](RESULTS.md) for the manual run, run summaries, and reflection.

| Folder | What it contains | Run from the repository root |
| --- | --- | --- |
| [robot/](robot/) | SeleniumLibrary suites with reusable QuickPizza keywords and locators. Two QP-01 reports and screenshot sets are under `robot/results/`. | `robot -d robot -v BROWSER:headlesschrome robot` |
| [cypress/](cypress/) | Two specs, a shared admin login command, and videos and screenshots of the second full run. | `npm --prefix cypress test` |

## Setup on another machine

Install Chrome, Python 3.10 or newer, and Node.js 22, 24, or 26. Download the [ChromeDriver](https://googlechromelabs.github.io/chrome-for-testing/) that matches your installed Chrome version and platform, and keep it outside the repository. Point `CHROMEDRIVER` at the executable.

For macOS and Linux, run the following from the repository root. In PowerShell, activate with `robot\.venv\Scripts\Activate.ps1` and set `$env:CHROMEDRIVER` to the full driver path.

```sh
python3 -m venv robot/.venv
source robot/.venv/bin/activate
python -m pip install -r robot/requirements.txt
export CHROMEDRIVER="/absolute/path/to/chromedriver"
npm --prefix cypress ci
```

On the prepared local checkout, run `source .env` and `source robot/.venv/bin/activate` before running the commands in the table. The local environment file is excluded from Git.

## Evidence

- Robot Framework reports: [run 1](robot/results/run1/report.html) and [run 2](robot/results/run2/report.html). For keyword details and embedded screenshots, open the corresponding `log.html` in a local browser.
- Cypress evidence: [screenshots](cypress/cypress/screenshots/) and [videos](cypress/cypress/videos/). A new Cypress run replaces the evidence files in these folders.
