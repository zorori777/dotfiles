RELEASE_TAG=$1
CURRENT_BRANCH=`git symbolic-ref --short HEAD`
BRANCH_HASH=`git rev-parse --verify --quiet $CURRENT_BRANCH`
GIT_DIFF=`git diff --name-only`
TODAY=`date '+%Y/%m/%d'`

if test "$GIT_DIFF" != ''; then
  echo 'fatal: Your local changes to the following files should be removed.'
  echo $GIT_DIFF
  exit 1
fi

if test "$RELEASE_TAG" = ''; then
  echo 'fatal: Please enter release tag name.'
  exit 1
fi

echo "close $CURRENT_BRANCH branch with tag:$RELEASE_TAG"

# 前処理
git push --set-upstream origin $CURRENT_BRANCH --quiet

# 本処理
git checkout master --quiet
git pull --quiet
git merge $CURRENT_BRANCH --no-ff --no-edit --quiet
git tag -a $RELEASE_TAG -m "close $CURRENT_BRANCH with tag:$RELEASE_TAG at $TODAY"

git checkout develop --quiet
git pull --quiet
git merge $RELEASE_TAG --no-ff  --no-edit --quiet

# 後処理
git push origin --tags --quiet
git push origin master:master --quiet
git push origin develop:develop --quiet
git branch -D $CURRENT_BRANCH --quiet
if test "$BRANCH_HASH" != ''; then
  echo "delete remote branch $CURRENT_BRANCH"
  git push --delete origin $CURRENT_BRANCH --quiet
fi
