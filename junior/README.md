# DevOps Engineer Homework

This starter contains three intentional issues. Allow approximately one hour
to troubleshoot them, verify your changes, and submit your work.

## Requirements

- Bash on Linux, macOS, WSL, or Git Bash on Windows.
- Git and a GitHub account with permission to run GitHub Actions.
- No cloud account, credentials, or additional packages are needed.

Run the commands below from the repository root in Bash.

## Task 1: Fix a failing script (15 minutes)

```bash
bash task-1-script/random-data.sh
```

Correct the failure and explain what the script is doing.

## Task 2: Resolve a configuration issue (15 minutes)

```bash
bash task-2-configuration/show-service.sh
```

This script runs from the repository root but fails from another directory.
Make it work regardless of the caller's working directory. Successful runs
must print `Service: sample-worker` and `Environment: test`.

To reproduce the other-directory behavior:

```bash
repo_root="$(pwd)"
(cd .. && bash "$repo_root/task-2-configuration/show-service.sh")
```

Also verify that a missing configuration produces a useful error and a nonzero
exit code. Restore the configuration after testing.

## Task 3: Repair the automated check (20 minutes)

Review `.github/workflows/check-scripts.yml` and the GitHub Actions logs.
Fix the workflow so both corrected scripts run successfully. Keep the push
and pull request triggers, and ensure a script failure fails the workflow.

## Submission (10 minutes)

- Create your own repository from this starter, or fork it if permitted.
- Make your fixes on a branch, commit and push them, and open a pull request
  against your repository's default branch. Leave it open for review.
- Add a short findings section to this README describing each issue, how you
  identified it, your fix, and the commands or checks used to verify it.
- Provide your repository URL, pull request URL, and a successful Actions run
  URL. For private repositories, grant reviewers access.
- Do not include credentials, secrets, or employer information.

Stop after approximately one hour. If anything remains unresolved, submit
your progress, what you tried, and what you would investigate next.

## Findings

### Task 1:
First, the script had a couple of typos. I was lucky that my code editor highlighted a U+2800 character and that helped me check other typos found.

One issue in the script is that bash variables can't hold null bytes, so it would just drop in the chance the randomly created bytes contained one.

Another issue is that command substitution strips new lines, so it could be unlucky that the last byte coudl be a new line and it would be stripped out.

Last issue I found is that appending with '<<<' appends a new line giving an innaccurate number of bytes based on the initial save.

### Task 2:
When running the script, the error is clear. It cannot find the file fetched. Why? For me it was easy to understand that the code path was relative and that's why it fails from other directories. Just adding a line to fetch the path of the current script in a variable and then prefix that variable to the path of the configuration file did the trick.

### Task 3:
The error in the pipeline clearly showed it can't find actions/checkout@v*9*. A quick google search on what is the actual version available of the checkout action and easy to replace the version value. On a quick glance before running again, I saw that the third step was missing the working directory which would make it fail similar to the issue on Task 2. Once I paid more attention to each step, I noticed the script names didn't match, so I just updated to the appropriate names and the pipeline was successful.
