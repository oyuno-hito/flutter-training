```mermaid
flowchart TB

subgraph Type
direction LR
widgetType((widget))
providerType[[provider]]
modelType[(model)]
end

subgraph UI Layer
    direction LR
    screen((screen))
    provider[[provider]]
    screen-->provider
    state[(state)]
end

subgraph Respository Layer
    repository[[repository]]
end

subgraph DataLayer
request[(request)]
response[(response)]
end

provider-->state
state-->response
repository-->response
repository-->request

provider-->repository
```

mermaid 図から分かる通り state が response モデルに依存しているが、研修では I/F の変更が入らず冗長化の恩恵が薄いためこれを許容する
