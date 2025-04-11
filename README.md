# 1. mérföldkő beadás

## Megvalósított elemek:
	1. Játékos által mozgatható karakter (WASD irányítás, SPACE-el való ugrás)
	2. Egy pálya
	3. Egy távolsági ellenfél, ha a játékos egy bizonyos távolságon belül van észrevesz és el kezdi lőni. Másként a saját platformján random járkál, megszakítva random megállásokkal. A lövésével le tudja lökni a játékos abba az irányba, ahonnan jött a lövés.
	4. A játékos le tudja lökni az ellenséget, ha egy bizonyos távolságon belül van (körülbelül majdnem mellette.) Ekkor az ellenfél leesik a platformról és eltűnik. Az F betű segítségével lehet lelökni az ellenfelet, ezt egy megjelenő szöveg indikálja.
	5. Ha a játékos eléri a pálya végén lévő sárga zászlót akkor teljesítette a pályát, a játék bezárul. 
	6. Ha a játékos leesik, akkor előlről kell kezdenie a pályát. Az addig lelökött ellenfelek nem élednek újra.

## Beállítások (ha valamiért nem működnének alapból)
- F gomb beállítása: Project -> Project Settings -> Input Map -> Add new action-be push_enemy -> Add megnyomása mellette -> a megjelenő action mellett alul  + gomb lenyomása (Add event) -> F gomb lenyomása (Listening for input) -> Ok
- game.tscn  a játék főszintere, innen indul el a játék
- első indításnál a játék ablaka el van csúszva, jobbról a harmadik gomb (Keep the aspect ratio of the embedded game), utána Három pontot megnyomva legjobboldalt -> Make game workspace floating for the next play -> játék újraindítása és utána már a játék be lesz ágyazva az editorba.