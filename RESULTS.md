# UI lab results

Tool parts chosen: **Part 3 (Robot Framework)** and **Part 4 (Cypress)**.

## Part 0

- Step 0.1, Chrome: Google Chrome 157.0.8103.50 (Official Build), arm64.
- Step 0.2: Downloaded the Chrome for Testing ChromeDriver archive for mac-arm64, version 157.0.8103.50, and extracted it outside the repository.
- Step 0.3: `chromedriver --version` confirmed 157.0.8103.50. The local environment exports `CHROMEDRIVER` with the path to the executable.
- Selenium form locator counts: `#my-text-id` matched 1 input, `input[type=checkbox]` matched 2 inputs, and `//button[normalize-space()='Submit']` matched 1 button.
- QuickPizza locator counts with Advanced on:

| Element | Locator | Matches |
| --- | --- | ---: |
| Pizza, Please! | `button[name="pizza-please"]` | 1 |
| Excluded tools | `select` | 1 |
| Must be vegetarian | `input#default-checkbox` | 1 |
| Custom Pizza Name | `input#pizza-name` | 1 |
| Max Calories per Slice | `//label[normalize-space()='Max Calories per Slice']/preceding-sibling::input` | 1 |
| Shared ID on the number fields | `#floating_filled` | 3 |
