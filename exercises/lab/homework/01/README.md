## Обща информация
### Краен срок: 08.12.2019, 23:59:59
### Максимум точки без бонуси: 30

## Setup
Инсталирайте `quickcheck`:
  * От команден ред (поне под `linux`):
      * `raco pkg install quickcheck`
  * От `DrRacket`:

      1. `File` dropdown
      2. цъкате `Package Manager`
      3. в `Package Source` полето пишете `quickcheck` и натискате `Install`

В `solutions/xno.rkt` можете да използвате функциите дефинирани в `solutions/matrix.rkt`,
благодарение на съответно `require` и `provide` извикванията.

## Running
* От команден ред:

    `racket <теста който искате да пуснете>`
* От `DrRacket`:

    Отваряте `<теста който искате да пуснете>` в `DrRacket` и цъкате `Run`

### Допълнителни инструкции за пускане на GUI-а към морския шах:

* От команден ред:

    `racket solutions/xno-main.rkt`

* От `DrRacket`

    Отваряте `solutions/xno-main.rkt` в `DrRacket` и цъкате `Run`

TODO(georgi): add tests for matrix at least
