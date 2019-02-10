# 変更したファイルにflake8をかける
git diff --cached --name-only --diff-filter=AM | grep '.py' | xargs flake8
