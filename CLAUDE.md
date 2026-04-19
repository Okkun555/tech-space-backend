# tech-space backend

## 技術構成
- Rails 8 APIモード
- PostgreSQL（Docker）
- Session Cookie認証（自作）
- Serializer（BluePrint）エラー用のシリアライザーのみ自作
- RSpec / FactoryBot / Faker / Shoulda-matchers

## ディレクトリ構成
```
app/
├── serializers/
│   └── error_serializer.rb
├── controllers/
│   └── api/
│       └── v1/
│           └── auth/
├── models/
└── spec/
    ├── factories/
    ├── models/
    └── requests/
```