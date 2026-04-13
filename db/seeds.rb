# 職種
occupations = %w(バックエンドエンジニア フロントエンドエンジニア フルスタックエンジニア インフラエンジニア QAエンジニア セキュリティエンジニア データベースエンジニア デザイナー プロダクトオーナー プロダクトマネージャー)
occupations.each do |name|
  Occupation.find_or_create_by!(name:)
end

# プログラム言語
programming_languages = %w(javascript typescript java python php ruby go kotlin rust c c++ c# swift)
programming_languages.each do |name|
  ProgrammingLanguage.find_or_create_by!(name:)
end