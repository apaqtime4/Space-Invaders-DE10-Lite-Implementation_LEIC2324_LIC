LIBRARY altera_mf;

USE altera_mf.altera_mf_components.all;

component sld_virtual_jtag
        generic (
                lpm_hint : string := "UNUSED";
                lpm_type :string := "sld_virtual_jtag";
                sld_auto_instance_index :       string := "NO";
                sld_instance_index: natural := 0;
                sld_ir_width:natural := 1;
                sld_sim_action  :string := "UNUSED";
                sld_sim_n_scan :natural := 0;
                sld_sim_total_length:natural := 0 );
        port(ir_in  : out std_logic_vector(sld_ir_width-1 downto 0);                ir_out  :       in std_logic_vector(sld_ir_width-1 downto 0);
                jtag_state_cdr  :       out std_logic;
                jtag_state_cir  :       out std_logic;
                jtag_state_e1dr :       out std_logic;
                jtag_state_e1ir :       out std_logic;
                jtag_state_e2dr :       out std_logic;
                jtag_state_e2ir :       out std_logic;
                jtag_state_pdr  :       out std_logic;
                jtag_state_pir  :       out std_logic;
                jtag_state_rti  :       out std_logic;
                jtag_state_sdr  :       out std_logic;
                jtag_state_sdrs :       out std_logic;
                jtag_state_sir  :       out std_logic;
                jtag_state_sirs :       out std_logic;
                jtag_state_tlr  :       out std_logic;
                jtag_state_udr  :       out std_logic;
                jtag_state_uir  :       out std_logic;
                tck     :       out std_logic;
                tdi     :       out std_logic;
                tdo     :       in std_logic;
                tms     :       out std_logic;
                virtual_state_cdr       :       out std_logic;
                virtual_state_cir       :       out std_logic;
                virtual_state_e1dr      :       out std_logic;
                virtual_state_e2dr      :       out std_logic;
                virtual_state_pdr       :       out std_logic;
                virtual_state_sdr       :       out std_logic;
                virtual_state_udr       :       out std_logic;
                virtual_state_uir       :       out std_logic
        );
end component;