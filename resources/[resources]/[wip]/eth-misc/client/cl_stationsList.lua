local StationsList = {
    "RADIO_01_CLASS_ROCK",
    "RADIO_02_POP",
    "RADIO_03_HIPHOP_NEW",
    "RADIO_04_PUNK",
    "RADIO_05_TALK_01",
    "RADIO_06_COUNTRY",
    "RADIO_07_DANCE_01",
    "RADIO_08_MEXICAN",
    "RADIO_09_HIPHOP_OLD",
    "RADIO_12_REGGAE",
    "RADIO_13_JAZZ",
    "RADIO_14_DANCE_02",
    "RADIO_15_MOTOWN",
    "RADIO_16_SILVERLAKE",
    "RADIO_17_FUNK",
    "RADIO_18_90S_ROCK",
    "RADIO_20_THELAB",
    "RADIO_21_DLC_XM17",
    "RADIO_22_DLC_BATTLE_MIX1_RADIO",
    "RADIO_23_DLC_XM19_RADIO",
    "RADIO_34_DLC_HEI4_KULT",
    "RADIO_35_DLC_HEI4_MLR",
    "RADIO_36_AUDIOPLAYER",
  }
  
  Citizen.CreateThread(function()
    for i=1, #StationsList do 
      SetRadioStationIsVisible(StationsList[i], 0)
    end
  end)
  