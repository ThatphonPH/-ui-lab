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

### QP-01 · A custom pizza reaches the admin list

Preconditions: QuickPizza is reachable and the Chrome Guest session is signed out. Test data: `Lab Pizza 20261110-113412`, maximum 600 calories per slice, exclude Knife, vegetarian checked, and QuickPizza's public demo admin credentials.

| Step | Action | Expected result | Actual result | Status |
| --- | --- | --- | --- | --- |
| 1 | Open QuickPizza. | The home heading appears. | The heading was “Looking to break out of your pizza routine?” | Pass |
| 2 | Turn on Advanced. | The calorie limit, excluded tools, vegetarian checkbox, and custom name appear. | All four controls appeared. The calorie limit started at 1000. | Pass |
| 3 | Set the calorie limit to 600, select Knife, check vegetarian, and enter the name. | Each control shows its specified value. | The number was 600, Knife was selected, vegetarian was checked, and the full name was entered. | Pass |
| 4 | Click Pizza, Please! | The recommendation shows the custom name, a tool other than Knife, and at most 600 calories per slice. | The recommendation showed `Lab Pizza 20261110-113412`, Scissors, and 600 calories per slice. | Pass |
| 5 | Click Love it! while signed out. | The page asks the guest to log in. | The message was “Please log in first.” | Pass |
| 6 | Open the admin page in the same Chrome session and sign in. | The latest recommendations heading appears. | The heading was “Latest pizza recommendations”. | Pass |
| 7 | Find the pizza by name in the admin list. | Its row shows the same tool as the recommendation. | The row read `Lab Pizza 20261110-113412 (tool=Scissors, ingredients_number=8)`. | Pass |

## Part 3 · Robot Framework

- `robot --version` reported Robot Framework 7.5.1 (Python 3.13.2 on darwin). SeleniumLibrary version was 6.9.0.
- Step 3.2 intentional wrong title: `Title should have been 'Web Form' but was 'Web form'.` The run reported 1 failed test. With the correct title restored, both web form tests passed.

| Step 3.8 | Result | Suite elapsed | Pizza name | Recommendation |
| --- | --- | ---: | --- | --- |
| [Run 1](robot/results/run1/) | 1 passed, 0 failed | 11.210 s | `Lab Pizza 20261110-113651` | Pizza cutter, 450 cal/slice |
| [Run 2](robot/results/run2/) | 1 passed, 0 failed | 9.748 s | `Lab Pizza 20261110-113701` | Scissors, 525 cal/slice |
