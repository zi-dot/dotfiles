function replace-all
    if test (count $argv) -ne 2
        echo "Usage: replace-all <検索文字列> <置換文字列>"
        return 1
    end

    set -l search (string escape -- $argv[1])
    set -l replace (string escape -- $argv[2])

    # ripgrep でマッチするファイル一覧を取得し、
    # xargs 経由で sed に渡して一括置換
    rg -l -- "$argv[1]" \
        | xargs sed -i '' "s/$search/$replace/g"
end
