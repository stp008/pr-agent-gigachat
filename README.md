<div align="center">

<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://www.qodo.ai/wp-content/uploads/2025/02/PR-Agent-Purple-2.png">
  <source media="(prefers-color-scheme: light)" srcset="https://www.qodo.ai/wp-content/uploads/2025/02/PR-Agent-Purple-2.png">
  <img src="https://codium.ai/images/pr_agent/logo-light.png" alt="logo" width="330">

</picture>
<br/>

[Руководство по установке](https://qodo-merge-docs.qodo.ai/installation/) |
[Руководство по использованию](https://qodo-merge-docs.qodo.ai/usage-guide/) |
[Руководство по инструментам](https://qodo-merge-docs.qodo.ai/tools/) |
[Qodo Merge](https://qodo-merge-docs.qodo.ai/overview/pr_agent_pro/) 💎

PR-Agent помогает эффективно просматривать и обрабатывать pull request'ы, предоставляя обратную связь и предложения на основе ИИ
</div>

[![Static Badge](https://img.shields.io/badge/Chrome-Extension-violet)](https://chromewebstore.google.com/detail/qodo-merge-ai-powered-cod/ephlnjeghhogofkifjloamocljapahnl)
[![Static Badge](https://img.shields.io/badge/Pro-App-blue)](https://github.com/apps/qodo-merge-pro/)
[![Static Badge](https://img.shields.io/badge/OpenSource-App-red)](https://github.com/apps/qodo-merge-pro-for-open-source/)
[![Discord](https://badgen.net/badge/icon/discord?icon=discord&label&color=purple)](https://discord.com/invite/SgSxuQ65GF)
<a href="https://github.com/Codium-ai/pr-agent/commits/main">
<img alt="GitHub" src="https://img.shields.io/github/last-commit/Codium-ai/pr-agent/main?style=for-the-badge" height="20">
</a>
</div>

## Содержание

- [Начало работы](#начало-работы)
- [Новости и обновления](#новости-и-обновления)
- [Почему использовать PR-Agent?](#почему-использовать-pr-agent)
- [Зачем использовать данный форк?](#зачем-использовать-данный-форк)
- [Возможности](#возможности)
- [Посмотреть в действии](#посмотреть-в-действии)
- [Попробовать сейчас](#попробовать-сейчас)
- [Qodo Merge 💎](#qodo-merge-)
- [Как это работает](#как-это-работает)
- [Конфиденциальность данных](#конфиденциальность-данных)
- [Участие в разработке](#участие-в-разработке)
- [Ссылки](#ссылки)

## Начало работы

### Попробуйте мгновенно
Протестируйте PR-Agent на любом публичном GitHub репозитории, оставив комментарий `@CodiumAI-Agent /improve`

### GitHub Action
Добавьте автоматические обзоры PR в ваш репозиторий с помощью простого workflow файла, используя [руководство по настройке GitHub Action](https://qodo-merge-docs.qodo.ai/installation/github/#run-as-a-github-action)

#### Другие платформы
- [Настройка webhook для GitLab](https://qodo-merge-docs.qodo.ai/installation/gitlab/)
- [Установка приложения BitBucket](https://qodo-merge-docs.qodo.ai/installation/bitbucket/)
- [Настройка Azure DevOps](https://qodo-merge-docs.qodo.ai/installation/azure/)

### Использование CLI
Запустите PR-Agent локально в вашем репозитории через командную строку: [Руководство по настройке локального CLI](https://qodo-merge-docs.qodo.ai/usage-guide/automations_and_usage/#local-repo-cli)

### Qodo Merge как post-commit в вашей локальной IDE
Смотрите [здесь](https://github.com/qodo-ai/agents/tree/main/agents/qodo-merge-post-commit)

### Откройте для себя Qodo Merge 💎
Готовое к использованию размещенное решение с расширенными функциями и приоритетной поддержкой
-  **[БЕСПЛАТНО для Open Source](https://github.com/marketplace/qodo-merge-pro-for-open-source)**: Полный функционал, нулевая стоимость для публичных репозиториев
-  [Введение и руководство по установке](https://qodo-merge-docs.qodo.ai/installation/qodo_merge/)
-  [Планы и цены](https://www.qodo.ai/pricing/)

### Qodo Merge как Post-commit в вашей локальной IDE
Вы можете получать автоматическую обратную связь от Qodo Merge в вашей локальной IDE после каждого [коммита](https://github.com/qodo-ai/agents/tree/main/agents/qodo-merge-post-commit)

## Зачем использовать данный форк

Этот форк адаптирован для использования русского языка и моделей **GigaChat** через прокси-сервер [litellm-gigachat](https://github.com/stp008/litellm-gigachat). Ключевые особенности:

- **Нативная интеграция GigaChat**: Используйте модели GigaChat (`gigachat-max`, `gigachat-pro`) с PR-Agent
- **Настройка webhook для Bitbucket Server**: Полное руководство по настройке PR-Agent как webhook сервера для Bitbucket Server
- **Простая конфигурация**: Простая конфигурация на основе TOML с поддержкой резервных моделей
- **Адаптация для русского языка**: Настроенные промпты для получения ответов на русском языке в инструментах помощи и документации

#### Быстрая настройка для GigaChat
1. Настройте прокси-сервер [litellm-gigachat](https://github.com/stp008/litellm-gigachat)
2. Сконфигурируйте PR-Agent с моделями GigaChat
3. Для Bitbucket Server: Следуйте [руководству по настройке Bitbucket webhook](docs/docs/installation/bitbucket_webhook.md)

## Новости и обновления

## 1 июля 2025
Теперь вы можете получать автоматическую обратную связь от Qodo Merge в вашей локальной IDE после каждого коммита. Читайте больше об этом [здесь](https://github.com/qodo-ai/agents/tree/main/agents/qodo-merge-post-commit).

## 21 июня 2025

Была [выпущена](https://github.com/qodo-ai/pr-agent/releases) версия v0.30


## 3 июня 2025

Qodo Merge теперь предлагает упрощенный бесплатный тариф 💎.
Организации могут использовать Qodo Merge бесплатно с [месячным лимитом](https://qodo-merge-docs.qodo.ai/installation/qodo_merge/#cloud-users) в 75 обзоров PR на организацию.


## 30 апреля 2025

Новая функция теперь доступна в инструменте `/improve` для Qodo Merge 💎 - Чат по предложениям кода.

<img width="512" alt="image" src="https://codium.ai/images/pr_agent/improve_chat_on_code_suggestions_ask.png" />

Читайте больше об этом [здесь](https://qodo-merge-docs.qodo.ai/tools/improve/#chat-on-code-suggestions).

## 16 апреля 2025

Новый инструмент для Qodo Merge 💎 - `/scan_repo_discussions`.

<img width="635" alt="image" src="https://codium.ai/images/pr_agent/scan_repo_discussions_2.png" />

Читайте больше об этом [здесь](https://qodo-merge-docs.qodo.ai/tools/scan_repo_discussions/).

## Почему использовать PR-Agent?

Разумный вопрос, который можно задать: `"Почему использовать PR-Agent? Что выделяет его среди существующих инструментов?"`

Вот некоторые преимущества PR-Agent:

- Мы делаем акцент на **практическом использовании в реальной жизни**. Каждый инструмент (review, improve, ask, ...) имеет один вызов LLM, не больше. Мы считаем, что это критично для реалистичного использования командой - получение ответа быстро (~30 секунд) и по доступной цене.
- Наша [стратегия сжатия PR](https://qodo-merge-docs.qodo.ai/core-abilities/#pr-compression-strategy) является основной способностью, которая позволяет эффективно работать как с короткими, так и с длинными PR.
- Наша стратегия JSON промптов позволяет нам иметь **модульные, настраиваемые инструменты**. Например, категории инструмента '/review' можно контролировать через файл [конфигурации](pr_agent/settings/configuration.toml). Добавление дополнительных категорий простое и доступное.
- Мы поддерживаем **множество git провайдеров** (GitHub, GitLab, BitBucket), **множество способов** использования инструмента (CLI, GitHub Action, GitHub App, Docker, ...), и **множество моделей** (GPT, Claude, Deepseek, ...)

## Возможности

<div style="text-align:left;">

PR-Agent и Qodo Merge предлагают комплексные функции pull request, интегрированные с различными git провайдерами:

|                                                         |                                                                                                                     | GitHub | GitLab | Bitbucket | Azure DevOps | Gitea |
|---------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|:------:|:------:|:---------:|:------------:|:-----:|
| [ИНСТРУМЕНТЫ](https://qodo-merge-docs.qodo.ai/tools/)         | [Описать](https://qodo-merge-docs.qodo.ai/tools/describe/)                                                         |   ✅   |   ✅   |    ✅     |      ✅      |  ✅   |
|                                                         | [Обзор](https://qodo-merge-docs.qodo.ai/tools/review/)                                                             |   ✅   |   ✅   |    ✅     |      ✅      |  ✅   |
|                                                         | [Улучшить](https://qodo-merge-docs.qodo.ai/tools/improve/)                                                           |   ✅   |   ✅   |    ✅     |      ✅      |  ✅   |
|                                                         | [Спросить](https://qodo-merge-docs.qodo.ai/tools/ask/)                                                                   |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | ⮑ [Спросить по строкам кода](https://qodo-merge-docs.qodo.ai/tools/ask/#ask-lines)                                         |   ✅   |   ✅   |           |              |       |
|                                                         | [Справочная документация](https://qodo-merge-docs.qodo.ai/tools/help_docs/?h=auto#auto-approval)                                  |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [Обновить CHANGELOG](https://qodo-merge-docs.qodo.ai/tools/update_changelog/)                                         |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Добавить документацию](https://qodo-merge-docs.qodo.ai/tools/documentation/) 💎                                        |   ✅   |   ✅   |           |              |       |
|                                                         | [Анализировать](https://qodo-merge-docs.qodo.ai/tools/analyze/) 💎                                                        |   ✅   |   ✅   |           |              |       |
|                                                         | [Авто-одобрение](https://qodo-merge-docs.qodo.ai/tools/improve/?h=auto#auto-approval) 💎                              |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [Обратная связь CI](https://qodo-merge-docs.qodo.ai/tools/ci_feedback/) 💎                                                |   ✅   |        |           |              |       |
|                                                         | [Пользовательский промпт](https://qodo-merge-docs.qodo.ai/tools/custom_prompt/) 💎                                            |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [Генерация пользовательских меток](https://qodo-merge-docs.qodo.ai/tools/custom_labels/) 💎                                   |   ✅   |   ✅   |           |              |       |
|                                                         | [Генерация тестов](https://qodo-merge-docs.qodo.ai/tools/test/) 💎                                                    |   ✅   |   ✅   |           |              |       |
|                                                         | [Реализация](https://qodo-merge-docs.qodo.ai/tools/implement/) 💎                                                    |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [Сканирование обсуждений репозитория](https://qodo-merge-docs.qodo.ai/tools/scan_repo_discussions/) 💎                            |   ✅   |        |           |              |       |
|                                                         | [Похожий код](https://qodo-merge-docs.qodo.ai/tools/similar_code/) 💎                                              |   ✅   |        |           |              |       |
|                                                         | [Контекст тикета](https://qodo-merge-docs.qodo.ai/core-abilities/fetching_ticket_context/) 💎                        |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [Использование лучших практик](https://qodo-merge-docs.qodo.ai/tools/improve/#best-practices) 💎                        |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [PR Чат](https://qodo-merge-docs.qodo.ai/chrome-extension/features/#pr-chat) 💎                                    |   ✅   |        |           |              |       |
|                                                         | [Отслеживание предложений](https://qodo-merge-docs.qodo.ai/tools/improve/#suggestion-tracking) 💎                        |   ✅   |   ✅   |           |              |       |
|                                                         |                                                                                                                     |        |        |           |              |       |
| [ИСПОЛЬЗОВАНИЕ](https://qodo-merge-docs.qodo.ai/usage-guide/)   | [CLI](https://qodo-merge-docs.qodo.ai/usage-guide/automations_and_usage/#local-repo-cli)                            |   ✅   |   ✅   |    ✅     |      ✅      |  ✅   |
|                                                         | [Приложение / webhook](https://qodo-merge-docs.qodo.ai/usage-guide/automations_and_usage/#github-app)                      |   ✅   |   ✅   |    ✅     |      ✅      |  ✅   |
|                                                         | [Бот с тегами](https://github.com/Codium-ai/pr-agent#try-it-now)                                                     |   ✅   |        |           |              |       |
|                                                         | [Actions](https://qodo-merge-docs.qodo.ai/installation/github/#run-as-a-github-action)                              |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         |                                                                                                                     |        |        |           |              |       |
| [ОСНОВНЫЕ ВОЗМОЖНОСТИ](https://qodo-merge-docs.qodo.ai/core-abilities/) | [Адаптивное и токен-осведомленное подгонка патчей файлов](https://qodo-merge-docs.qodo.ai/core-abilities/compression_strategy/) |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Авто лучшие практики 💎](https://qodo-merge-docs.qodo.ai/core-abilities/auto_best_practices/)                       |   ✅   |      |         |            |   |
|                                                         | [Чат по предложениям кода](https://qodo-merge-docs.qodo.ai/core-abilities/chat_on_code_suggestions/)                |   ✅   |  ✅   |           |              |       |
|                                                         | [Валидация кода 💎](https://qodo-merge-docs.qodo.ai/core-abilities/code_validation/)                               |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Динамический контекст](https://qodo-merge-docs.qodo.ai/core-abilities/dynamic_context/)                                  |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Получение контекста тикета](https://qodo-merge-docs.qodo.ai/core-abilities/fetching_ticket_context/)                  |   ✅    |  ✅    |     ✅     |              |       |
|                                                         | [Глобальные и wiki конфигурации](https://qodo-merge-docs.qodo.ai/usage-guide/configuration_options/) 💎             |   ✅   |   ✅   |    ✅     |              |       |
|                                                         | [Оценка влияния](https://qodo-merge-docs.qodo.ai/core-abilities/impact_evaluation/) 💎                           |   ✅   |   ✅   |           |              |       |
|                                                         | [Инкрементальное обновление](https://qodo-merge-docs.qodo.ai/core-abilities/incremental_update/)                            |   ✅    |       |           |              |       |
|                                                         | [Интерактивность](https://qodo-merge-docs.qodo.ai/core-abilities/interactivity/)                                      |   ✅   |  ✅   |           |              |       |
|                                                         | [Локальные и глобальные метаданные](https://qodo-merge-docs.qodo.ai/core-abilities/metadata/)                               |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Поддержка множества моделей](https://qodo-merge-docs.qodo.ai/usage-guide/changing_a_model/)                            |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Сжатие PR](https://qodo-merge-docs.qodo.ai/core-abilities/compression_strategy/)                              |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Интерактивные действия PR](https://www.qodo.ai/images/pr_agent/pr-actions.mp4) 💎                                     |   ✅   |   ✅   |           |              |       |
|                                                         | [Обогащение контекста RAG](https://qodo-merge-docs.qodo.ai/core-abilities/rag_context_enrichment/)                    |   ✅    |       |    ✅     |              |       |
|                                                         | [Саморефлексия](https://qodo-merge-docs.qodo.ai/core-abilities/self_reflection/)                                  |   ✅   |   ✅   |    ✅     |      ✅      |       |
|                                                         | [Статический анализ кода](https://qodo-merge-docs.qodo.ai/core-abilities/static_code_analysis/) 💎                     |   ✅   |   ✅   |           |              |       |
- 💎 означает, что эта функция доступна только в [Qodo Merge](https://www.qodo.ai/pricing/)

[//]: # (- Поддержка дополнительных git провайдеров описана [здесь]&#40;./docs/Full_environments.md&#41;)
___

## Посмотреть в действии

</div>
<h4><a href="https://github.com/Codium-ai/pr-agent/pull/530">/describe</a></h4>
<div align="center">
<p float="center">
<img src="https://www.codium.ai/images/pr_agent/describe_new_short_main.png" width="512">
</p>
</div>
<hr>

<h4><a href="https://github.com/Codium-ai/pr-agent/pull/732#issuecomment-1975099151">/review</a></h4>
<div align="center">
<p float="center">
<kbd>
<img src="https://www.codium.ai/images/pr_agent/review_new_short_main.png" width="512">
</kbd>
</p>
</div>
<hr>

<h4><a href="https://github.com/Codium-ai/pr-agent/pull/732#issuecomment-1975099159">/improve</a></h4>
<div align="center">
<p float="center">
<kbd>
<img src="https://www.codium.ai/images/pr_agent/improve_new_short_main.png" width="512">
</kbd>
</p>
</div>

<div align="left">

</div>
<hr>

## Попробовать сейчас

Попробуйте PR-Agent на базе Claude Sonnet мгновенно на _вашем публичном GitHub репозитории_. Просто упомяните `@CodiumAI-Agent` и добавьте желаемую команду в любом комментарии PR. Агент сгенерирует ответ на основе вашей команды.
Например, добавьте комментарий к любому pull request со следующим текстом:

```
@CodiumAI-Agent /review
```

и агент ответит обзором вашего PR.

Обратите внимание, что это промо-бот, подходящий только для первоначального экспериментирования.
У него нет доступа для 'редактирования' вашего репозитория, например, поэтому он не может обновить описание PR или добавить метки (`@CodiumAI-Agent /describe` опубликует описание PR как комментарий). Кроме того, бот не может использоваться в приватных репозиториях, так как у него нет доступа к файлам там.

---

## Qodo Merge 💎

[Qodo Merge](https://www.qodo.ai/pricing/) - это размещенная версия PR-Agent, предоставляемая Qodo. Она доступна за ежемесячную плату и предоставляет следующие преимущества:

1. **Полностью управляемый** - Мы заботимся обо всем за вас - хостинг, модели, регулярные обновления и многое другое. Установка так же проста, как регистрация и добавление приложения Qodo Merge в ваш GitHub/GitLab/BitBucket репозиторий.
2. **Улучшенная конфиденциальность** - Никакие данные не будут храниться или использоваться для обучения моделей. Qodo Merge будет использовать нулевое хранение данных и будет использовать аккаунт OpenAI с нулевым хранением данных.
3. **Улучшенная поддержка** - Пользователи Qodo Merge получат приоритетную поддержку и смогут запрашивать новые функции и возможности.
4. **Дополнительные функции** - В дополнение к перечисленным выше преимуществам, Qodo Merge будет делать акцент на большей кастомизации и использовании статического анализа кода в дополнение к логике LLM для улучшения результатов.
Смотрите [здесь](https://qodo-merge-docs.qodo.ai/overview/pr_agent_pro/) список функций, доступных в Qodo Merge.

## Как это работает

Следующая диаграмма иллюстрирует инструменты PR-Agent и их поток:

![PR-Agent Tools](https://www.qodo.ai/images/pr_agent/diagram-v0.9.png)

Ознакомьтесь со страницей [стратегии сжатия PR](https://qodo-merge-docs.qodo.ai/core-abilities/#pr-compression-strategy) для получения более подробной информации о том, как мы преобразуем diff кода в управляемый промпт LLM

## Конфиденциальность данных

### Самостоятельно размещенный PR-Agent

- Если вы размещаете PR-Agent с вашим API ключом OpenAI, это между вами и OpenAI. Вы можете прочитать их политику конфиденциальности API данных здесь:
https://openai.com/enterprise-privacy

### Qodo-размещенный Qodo Merge 💎

- При использовании Qodo Merge 💎, размещенного Qodo, мы не будем хранить ваши данные и не будем использовать их для обучения. Вы также получите преимущества от аккаунта OpenAI с нулевым хранением данных.

- Для определенных клиентов Qodo-размещенный Qodo Merge будет использовать собственные модели Qodo — если это так, вы будете уведомлены.

- Никакого пассивного сбора данных кода и Pull Request'ов — Qodo Merge будет активен только когда вы его вызываете, и затем он будет извлекать и анализировать только данные, относящиеся к выполняемой команде и запрашиваемому pull request.

### Расширение Chrome для Qodo Merge

- [Расширение Chrome для Qodo Merge](https://chromewebstore.google.com/detail/qodo-merge-ai-powered-cod/ephlnjeghhogofkifjloamocljapahnl) служит исключительно для изменения визуального вида экрана GitHub PR. Оно не передает код репозитория или pull request пользователя. Код отправляется для обработки только когда пользователь отправляет комментарий GitHub, который активирует инструмент PR-Agent, в соответствии со стандартной политикой конфиденциальности Qodo-Merge.

## Участие в разработке

Чтобы внести вклад в проект, начните с чтения нашего [Руководства по участию](https://github.com/qodo-ai/pr-agent/blob/b09eec265ef7d36c232063f76553efb6b53979ff/CONTRIBUTING.md).

## Ссылки

- Discord сообщество: https://discord.com/invite/SgSxuQ65GF
- Сайт Qodo: https://www.qodo.ai/
- Блог: https://www.qodo.ai/blog/
- Устранение неполадок: https://www.qodo.ai/blog/technical-faq-and-troubleshooting/
- Поддержка: support@qodo.ai
