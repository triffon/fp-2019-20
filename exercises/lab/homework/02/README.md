## Обща информация
### Краен срок: ?, 23:59:59
### Максимум точки без бонуси: 10

## Setup
Инсталирайте `stack`:
  * Ако сте си инсталирали `ghc` посредством [`Haskell Platform`](https://www.haskell.org/platform/),
    то вече имате и `stack`.
  * В противен случай - [инструкции за инсталиране](https://docs.haskellstack.org/en/stable/install_and_upgrade/)

## Running
**N.B. Първото пускане ще отнеме сравнитлено голямо количество време, тъй като `stack` тегли специфична версия на `ghc` и специфични пакети за нея, които са проверени че работят заедно**

* От команден ред:
  * `stack build` - компилира source файловете ви
  * `stack ghci` - пуска `ghci` в което са заредени source файловете ви
  * `stack test` - пуска тестовете към домашното
  * `stack test --flag third-hw:nonempty` - пуска **и** тестовете към бонус задачите

Флагът `--file-watch` на `stack` е много удобен - когато го подадете към
`stack build/test` автоматично прекомпилира (и съответно пуска тестовете),
при промяна на някой source файл.

Примери:
* `stack test --file-watch`
* `stack test --file-watch --flag third-hw:nonempty`