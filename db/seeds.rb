occupations = %w(バックエンドエンジニア フロントエンドエンジニア フルスタックエンジニア インフラエンジニア QAエンジニア セキュリティエンジニア データベースエンジニア デザイナー プロダクトオーナー プロダクトマネージャー)
occupations.each do |name|
  Occupation.find_or_create_by!(name:)
end