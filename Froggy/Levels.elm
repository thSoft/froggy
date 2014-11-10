module Froggy.Levels where

import Array
import Froggy.Grid as Grid

type Level = {
  frogPosition: Grid.Position,
  leafMatrix: LeafMatrix,
  levelPosition: Grid.Position
}

type LeafMatrix = [[Bool]]

levels =
  Array.fromList [
    -- 0
    {
      frogPosition = {
        x = 6,
        y = 1
      },
      leafMatrix = [
        [False, False, False, False, True , False, False, False], 
        [False, True , True , True , True , True , True , False], 
        [False, True , False, False, True , False, False, False], 
        [False, True , False, False, True , False, False, False], 
        [True , True , False, False, True , True , True , False], 
        [True , False, False, False, False, False, True , False], 
        [True , True , True , True , True , True , True , False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 6,
        y = 0
      }
    },
    -- 1
    {
      frogPosition = {
        x = 5,
        y = 2
      },
      leafMatrix = [
        [True , False, False, False, False, False, False, False], 
        [True , True , True , True , False, False, False, False], 
        [True , False, False, False, True , True , True , False], 
        [True , False, False, False, False, False, False, False], 
        [True , False, True , True , True , False, False, False], 
        [False, False, False, True , False, False, False, False], 
        [True , True , True , True , False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 5,
        y = 3
      }
    }, 
    -- 2
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, False, False, False, False, True , False, False], 
        [False, False, True , False, True , True , True , False], 
        [False, False, False, False, False, True , False, False], 
        [False, False, True , False, False, False, False, False], 
        [False, True , True , True , False, True , False, False], 
        [False, False, True , False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 3
    {
      frogPosition = {
        x = 0,
        y = 2
      },
      leafMatrix = [
        [True , False, False, False, False, False, False, False], 
        [True , False, True , False, True , False, True , False], 
        [True , False, False, False, True , False, True , False], 
        [False, False, False, False, True , False, True , False], 
        [False, False, False, False, False, False, True , False], 
        [True , True , True , True , False, False, False, False], 
        [False, False, False, False, True , True , True , False], 
        [False, False, False, True , True , True , True , False]
      ],
      levelPosition = {
        x = 0,
        y = 3
      }
    }, 
    -- 4
    {
      frogPosition = {
        x = 4,
        y = 4
      },
      leafMatrix = [
        [False, False, True , False, False, False, False, False], 
        [False, False, True , False, False, False, False, False], 
        [False, True , True , True , False, False, False, False], 
        [False, False, True , False, True , False, False, False], 
        [False, True , False, False, True , False, True , False], 
        [True , True , False, True , True , True , True , False], 
        [False, True , False, False, False, False, True , False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 0
      }
    }, 
    -- 5
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [False, False, False, True , False, True , False, False], 
        [False, False, False, True , False, False, False, False], 
        [False, False, False, False, False, True , True , False], 
        [False, False, True , True , True , True , False, False], 
        [False, False, False, False, False, False, True , False], 
        [False, True , False, True , False, False, False, False], 
        [False, False, False, True , False, True , True , False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 3
      }
    }, 
    -- 6
    {
      frogPosition = {
        x = 1,
        y = 0
      },
      leafMatrix = [
        [False, True , False, False, False, False, False, False], 
        [True , True , True , False, True , False, True , False], 
        [False, False, False, True , False, True , True , False], 
        [False, False, False, True , False, False, True , False], 
        [False, True , True , True , True , True , False, False], 
        [False, True , False, True , False, True , True , False], 
        [False, False, False, False, False, True , False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 7
    {
      frogPosition = {
        x = 3,
        y = 3
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, False, False, False, True , True , True , False], 
        [False, True , False, True , False, False, True , False], 
        [False, True , True , True , True , False, False, False], 
        [False, False, False, False, False, False, True , False], 
        [False, False, True , True , True , True , False, False], 
        [False, False, False, False, False, False, True , False], 
        [False, False, False, False, False, True , True , False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 8
    {
      frogPosition = {
        x = 6,
        y = 0
      },
      leafMatrix = [
        [False, False, False, True , True , True , True , False], 
        [False, True , True , False, False, False, False, False], 
        [False, False, False, True , True , True , False, False], 
        [True , False, True , False, True , False, True , False], 
        [True , True , True , False, True , False, False, False], 
        [True , False, False, False, False, False, True , False], 
        [True , False, True , False, False, False, False, False], 
        [True , False, True , False, True , True , True , True ]
      ],
      levelPosition = {
        x = 7,
        y = 0
      }
    }, 
    -- 9
    {
      frogPosition = {
        x = 6,
        y = 2
      },
      leafMatrix = [
        [False, True , True , True , False, True , False, True ], 
        [False, False, False, False, True , True , False, False], 
        [False, True , False, False, True , False, True , True ], 
        [False, False, True , False, False, True , False, True ], 
        [True , True , True , False, True , False, True , False], 
        [True , False, True , False, False, True , False, False], 
        [True , True , True , True , True , False, True , False], 
        [False, False, False, True , False, True , False, False]
      ],
      levelPosition = {
        x = 0,
        y = 1
      }
    }, 
    -- 10
    {
      frogPosition = {
        x = 6,
        y = 1
      },
      leafMatrix = [
        [False, False, False, False, False, False, True , False], 
        [False, True , False, False, False, False, True , False], 
        [False, True , False, False, True , True , True , False], 
        [True , True , False, False, True , True , False, False], 
        [False, True , False, False, True , False, False, False], 
        [False, False, True , True , False, True , False, False], 
        [True , True , True , False, False, False, False, False], 
        [True , False, True , False, False, False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 11
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [False, False, False, True , False, True , False, False], 
        [False, True , False, True , True , True , True , True ], 
        [False, True , False, True , False, True , False, False], 
        [True , True , True , False, False, True , False, True ], 
        [False, True , False, False, True , True , True , True ], 
        [False, False, True , False, False, False, False, False], 
        [False, False, False, True , True , True , False, False], 
        [False, False, True , False, True , False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 12
    {
      frogPosition = {
        x = 6,
        y = 2
      },
      leafMatrix = [
        [False, False, True , False, True , True , False, True ], 
        [False, False, True , False, False, True , False, True ], 
        [False, False, True , True , True , False, True , False], 
        [False, False, True , False, False, False, False, False], 
        [False, False, False, True , False, True , True , True ], 
        [False, False, True , False, True , False, True , False], 
        [False, False, False, False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 7
      }
    }, 
    -- 13
    {
      frogPosition = {
        x = 6,
        y = 2
      },
      leafMatrix = [
        [False, False, False, False, True , False, False, False], 
        [True , True , True , False, True , False, False, True ], 
        [False, False, True , True , True , True , True , True ], 
        [False, True , False, False, False, False, False, False], 
        [True , True , True , False, True , False, False, True ], 
        [False, True , False, True , True , False, True , True ], 
        [False, False, False, False, True , False, False, False], 
        [False, True , True , False, True , False, True , False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 14
    {
      frogPosition = {
        x = 1,
        y = 6
      },
      leafMatrix = [
        [True , False, True , False, True , False, False, True ], 
        [False, False, True , False, False, False, False, False], 
        [True , False, True , False, True , False, True , True ], 
        [False, True , True , True , False, True , True , False], 
        [False, False, False, False, False, False, True , False], 
        [True , False, False, True , True , False, False, False], 
        [True , True , False, False, True , False, True , False], 
        [True , False, True , True , True , False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 15
    {
      frogPosition = {
        x = 4,
        y = 6
      },
      leafMatrix = [
        [True , False, True , True , True , True , True , False], 
        [True , False, True , False, True , False, False, False], 
        [False, True , False, True , True , True , False, True ], 
        [True , False, True , False, True , False, True , False], 
        [False, True , False, False, True , False, False, True ], 
        [True , False, True , True , True , False, True , False], 
        [True , True , False, False, True , False, False, True ], 
        [True , False, False, True , False, True , False, True ]
      ],
      levelPosition = {
        x = 7,
        y = 0
      }
    }, 
    -- 16
    {
      frogPosition = {
        x = 4,
        y = 2
      },
      leafMatrix = [
        [True , True , True , False, True , False, False, False], 
        [False, False, False, True , True , True , False, False], 
        [False, True , False, False, True , False, False, False], 
        [False, True , False, True , True , True , False, False], 
        [True , True , False, False, True , False, False, False], 
        [False, True , False, False, True , False, False, False], 
        [False, True , False, False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 4,
        y = 7
      }
    }, 
    -- 17
    {
      frogPosition = {
        x = 4,
        y = 7
      },
      leafMatrix = [
        [True , True , True , True , True , True , True , True ], 
        [True , False, False, False, True , False, False, True ], 
        [True , False, True , False, True , False, False, True ], 
        [True , False, False, False, True , True , True , True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , False, True , False, False, True , False, True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , True , True , True , True , True , True , True ]
      ],
      levelPosition = {
        x = 3,
        y = 4
      }
    }, 
    -- 18
    {
      frogPosition = {
        x = 3,
        y = 5
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, True , True , True , True , False, False, True ], 
        [True , False, True , False, False, False, False, True ], 
        [True , True , False, False, False, True , False, True ], 
        [True , False, True , False, False, True , False, False], 
        [False, True , True , True , False, True , False, True ], 
        [False, False, False, False, False, True , False, False], 
        [False, False, True , False, True , True , True , False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 19
    {
      frogPosition = {
        x = 4,
        y = 4
      },
      leafMatrix = [
        [False, False, True , False, True , False, False, False], 
        [False, False, True , False, False, True , True , False], 
        [False, False, False, False, True , False, False, False], 
        [True , True , True , True , False, False, True , False], 
        [False, False, False, False, True , False, False, False], 
        [False, False, False, True , False, False, True , False], 
        [False, False, False, True , True , True , True , False], 
        [False, False, False, False, True , False, True , False]
      ],
      levelPosition = {
        x = 7,
        y = 4
      }
    }, 
    -- 20
    {
      frogPosition = {
        x = 4,
        y = 3
      },
      leafMatrix = [
        [False, False, False, False, False, True , True , True ], 
        [False, False, False, True , False, True , True , False], 
        [True , True , True , True , True , False, False, False], 
        [False, True , False, True , True , False, True , False], 
        [False, False, False, False, False, True , True , False], 
        [False, False, False, False, False, False, True , False], 
        [False, True , False, True , True , True , True , False], 
        [True , True , True , False, True , False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 21
    {
      frogPosition = {
        x = 1,
        y = 6
      },
      leafMatrix = [
        [False, False, False, False, False, True , False, False], 
        [False, False, False, False, False, True , False, True ], 
        [False, False, False, False, False, True , True , True ], 
        [False, False, False, True , True , True , False, False], 
        [False, False, False, True , False, True , False, False], 
        [False, True , False, True , False, False, False, True ], 
        [True , True , True , False, True , False, False, False], 
        [False, True , False, False, True , True , False, True ]
      ],
      levelPosition = {
        x = 0,
        y = 7
      }
    }, 
    -- 22
    {
      frogPosition = {
        x = 0,
        y = 7
      },
      leafMatrix = [
        [True , True , True , True , False, True , False, True ], 
        [False, False, False, False, False, True , True , True ], 
        [False, False, True , True , False, False, True , False], 
        [False, False, False, False, True , True , True , False], 
        [True , True , False, True , False, True , False, False], 
        [False, False, True , False, True , True , False, False], 
        [True , False, False, False, False, False, False, False], 
        [True , True , True , True , True , False, False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 23
    {
      frogPosition = {
        x = 2,
        y = 6
      },
      leafMatrix = [
        [False, False, False, False, False, False, False, False], 
        [False, True , False, True , False, True , False, True ], 
        [True , False, True , True , True , False, True , True ], 
        [False, True , False, True , False, False, False, True ], 
        [True , False, True , False, False, False, True , False], 
        [False, False, False, False, True , False, True , False], 
        [False, True , True , True , True , False, True , False], 
        [False, True , False, False, False, False, True , False]
      ],
      levelPosition = {
        x = 4,
        y = 0
      }
    }, 
    -- 24
    {
      frogPosition = {
        x = 7,
        y = 0
      },
      leafMatrix = [
        [True , True , True , True , False, True , True , True ], 
        [False, False, False, True , False, True , False, False], 
        [False, False, False, True , False, True , False, False], 
        [True , True , True , True , False, True , True , True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , False, False, False, False, False, False, True ], 
        [True , True , True , True , False, True , True , True ], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 4,
        y = 4
      }
    }, 
    -- 25
    {
      frogPosition = {
        x = 5,
        y = 3
      },
      leafMatrix = [
        [True , False, True , False, True , False, False, False], 
        [True , True , False, True , True , True , False, True ], 
        [False, False, False, False, True , False, False, True ], 
        [False, False, False, True , True , True , False, False], 
        [False, False, False, False, True , False, False, True ], 
        [False, False, False, True , False, False, False, True ], 
        [False, True , True , True , False, True , False, True ], 
        [False, False, True , True , True , False, False, True ]
      ],
      levelPosition = {
        x = 0,
        y = 3
      }
    }, 
    -- 26
    {
      frogPosition = {
        x = 4,
        y = 7
      },
      leafMatrix = [
        [False, False, False, False, False, True , True , True ], 
        [False, False, False, False, False, True , False, False], 
        [False, False, False, True , False, False, True , False], 
        [False, False, False, True , False, True , True , False], 
        [False, False, True , True , True , False, True , True ], 
        [False, True , False, False, False, False, True , False], 
        [True , True , True , False, False, False, True , True ], 
        [False, True , True , True , True , False, False, False]
      ],
      levelPosition = {
        x = 0,
        y = 0
      }
    }, 
    -- 27
    {
      frogPosition = {
        x = 3,
        y = 5
      },
      leafMatrix = [
        [True , False, True , False, True , False, True , True ], 
        [False, True , False, True , False, True , False, True ], 
        [True , False, True , False, True , False, False, False], 
        [False, True , False, True , False, True , True , True ], 
        [False, True , True , False, True , False, True , False], 
        [True , True , True , True , False, False, True , False], 
        [False, True , False, False, False, False, False, False], 
        [False, False, False, False, False, False, False, False]
      ],
      levelPosition = {
        x = 6,
        y = 7
      }
    }, 
    -- 28
    {
      frogPosition = {
        x = 5,
        y = 5
      },
      leafMatrix = [
        [False, True , False, True , True , False, True , False], 
        [True , True , False, False, False, False, False, False], 
        [True , False, True , True , False, True , False, True ], 
        [False, False, True , False, True , False, True , False], 
        [True , False, False, True , False, True , False, True ], 
        [True , False, True , True , False, True , True , True ], 
        [True , False, False, True , False, True , False, False], 
        [False, False, True , False, True , True , False, False]
      ],
      levelPosition = {
        x = 7,
        y = 7
      }
    }, 
    -- 29
    {
      frogPosition = {
        x = 7,
        y = 0
      },
      leafMatrix = [
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [True , True , True , True , True , True , True , True ], 
        [False, True , True , True , True , True , True , True ]
      ],
      levelPosition = {
        x = 0,
        y = 7
      }
    }
  ]

numberOfLevels = levels |> Array.length