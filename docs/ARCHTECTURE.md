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
    subgraph provider
        notifier[[notifier]]
    end
    screen-->notifier
    subgraph state
        stateModel[(state)]
    end
end

subgraph Respository Layer
    repository[[repository]]
end

subgraph DataLayer
request[(request)]
response[(response)]
end

notifier-->stateModel
stateModel-->response
repository-->response
repository-->request

notifier-->repository
```

mermaid 図から分かる通り state が response モデルに依存しているが、研修では I/F の変更が入らず冗長化の恩恵が薄いためこれを許容する
