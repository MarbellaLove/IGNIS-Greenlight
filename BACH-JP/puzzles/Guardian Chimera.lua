Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_PSEUDO_SHUFFLE+DUEL_TEST_MODE,5)
Debug.SetPlayerInfo(0,100,0,0)
Debug.SetPlayerInfo(1,3200,0,0)

Debug.AddCard(72677437,0,0,LOCATION_HAND,1,POS_FACEDOWN)
--Debug.AddCard(83957459,0,0,LOCATION_HAND,1,POS_FACEDOWN)
--Debug.AddCard(43694481,0,0,LOCATION_HAND,1,POS_FACEDOWN)
Debug.AddCard(24094653,0,0,LOCATION_HAND,1,POS_FACEDOWN)
Debug.AddCard(74335036,0,0,LOCATION_HAND,1,POS_FACEDOWN)
--Debug.AddCard(48130397,0,0,LOCATION_HAND,1,POS_FACEDOWN)

Debug.AddCard(72677437,0,0,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(83957459,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(43694481,0,0,LOCATION_MZONE,3,POS_FACEUP_ATTACK)

Debug.AddCard(56120475,0,0,LOCATION_DECK,1,POS_FACEDOWN)
Debug.AddCard(56120475,0,0,LOCATION_DECK,1,POS_FACEDOWN)

Debug.AddCard(101107040,0,0,LOCATION_EXTRA,1,POS_FACEDOWN)

Debug.AddCard(72677437,1,1,LOCATION_MZONE,1,POS_FACEUP_ATTACK)
Debug.AddCard(83957459,1,1,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(43694481,1,1,LOCATION_MZONE,3,POS_FACEUP_ATTACK)

Debug.AddCard(56120475,1,1,LOCATION_SZONE,2,POS_FACEDOWN)

Debug.ReloadFieldEnd()