--version  = 1
--Eplanner version = 2022.6.8216.27630
------------------------------------------------------------------------------
PAC_name = 'T1-Scales-Demo'
PAC_id = '64660'
------------------------------------------------------------------------------
--Узлы IO
nodes =
    {
        {
        name    = 'A1',
        ntype   = 201, --AXC F 2152
        n       = 1,
        IP      = '10.162.0.236',
        modules =
            {
            }
        },
        {
        name    = 'A100',
        ntype   = 200, --AXL F BK ETH
        n       = 2,
        IP      = '10.162.0.237',
        modules =
            {
             { 2688666 },        --AXL F RS UNI 1H,
            }
        },
    }
------------------------------------------------------------------------------
--Устройства
devices =
    {
        {
        name    = 'T1WT1',
        descr   = 'Весы',
        dtype   = 17,
        subtype = 3, -- WT_RS232
        article = 'WT_RS232',
        AO =
            {
                {
                node          = 1,
                offset        = 0,
                physical_port = 2,
                logical_port  = 1,
                module_offset = 0
                },
            },
        AI =
            {
                {
                node          = 1,
                offset        = 0,
                physical_port = 2,
                logical_port  = 1,
                module_offset = 0
                },
            },
        par = {0 --[[P_C0]] }
        },

    }
