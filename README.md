README
===

ActiveJobのAdapterを作ってみる実験アプリです。

バックエンドとして AmazonSQS を使ってみます。

```
[vagrant@localhost vagrant] export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
[vagrant@localhost vagrant] export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
[vagrant@localhost vagrant] export AWS_REGION=ap-northeast-1
```

```
[vagrant@localhost vagrant] bundle exec rails s -b 0.0.0.0  -d
[vagrant@localhost vagrant] bundle exec rake sqs:worker:start &
[vagrant@localhost vagrant] mailcatcher --http-ip 0.0.0.0
```

## Files

### lib/sqs_adapter.rb

Amazon SQS Adapter Sample

### lib/tasks/sqs.rake

Amazon SQS Worker Sample
