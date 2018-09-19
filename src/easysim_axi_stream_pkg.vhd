library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

library work;
    use work.easysim_axi_common_pkg.all;


package easysim_axi_stream_pkg is
  -- Execute an AXI-Stream transaction as a master.
  -- Improvements: Allow narrow bursts. Allow tstrb signal.
  procedure m_axis_txn(
    signal aclk     : in    std_logic;
    signal aresetn  : in    std_logic;
    signal tready   : in    std_logic;
    signal tvalid   : inout std_logic;
    signal tdata    : out   std_logic_vector;
    signal tkeep    : out   std_logic_vector;
    signal tlast    : out   std_logic;
    signal tuser    : out   std_logic_vector;
    signal txn_data : in    byte_vector_t;
    signal txn_user_data : in std_logic_vector
  );
  
  -- Execute an AXI-Stream transaction as a slave.
  procedure s_axis_txn(
    signal aclk     : in    std_logic;
    signal aresetn  : in    std_logic;
    signal tready   : inout std_logic;
    signal tvalid   : in    std_logic;
    signal tdata    : in    std_logic_vector;
    signal tkeep    : in    std_logic_vector;
    signal tlast    : in    std_logic;
    signal tuser    : in    std_logic_vector;
    signal txn_data : out   byte_vector_t;
    signal txn_user_data : out std_logic_vector
  );
end package easysim_axi_stream_pkg;


package body easysim_axi_stream_pkg is
    procedure m_axis_txn(
        signal aclk     : in    std_logic;
        signal aresetn  : in    std_logic;
        signal tready   : in    std_logic;
        signal tvalid   : inout std_logic;
        signal tdata    : out   std_logic_vector;
        signal tkeep    : out   std_logic_vector;
        signal tlast    : out   std_logic;
        signal tuser    : out   std_logic_vector;
        signal txn_data : in    byte_vector_t;
        signal txn_user_data : in std_logic_vector
    ) is
        constant TDATA_BYTES : integer := tdata'length/8;
        constant TUSER_BITS_PER_TDATA_BYTE : integer := tuser'length/TDATA_BYTES;
    begin
        assert tdata'length mod 8 = 0
        report "m_axis_txn: Invalid width for tdata." severity ERROR;
        wait until (aresetn = '1') and (aresetn'event or aclk'event);
        for i in txn_data'low/TDATA_BYTES to txn_data'high/TDATA_BYTES loop
            tvalid <= '1';
            tkeep <= (others => '0');
            for j in 0 to TDATA_BYTES-1 loop
                if (i*TDATA_BYTES+j <= txn_data'high) then
                    tdata((j+1)*8-1 downto j*8) <= txn_data(i*TDATA_BYTES+j);
                    tuser((j+1)*TUSER_BITS_PER_TDATA_BYTE-1 downto j*TUSER_BITS_PER_TDATA_BYTE) <=
                        txn_user_data((i+1)*TDATA_BYTES*TUSER_BITS_PER_TDATA_BYTE-1 downto i*TDATA_BYTES*TUSER_BITS_PER_TDATA_BYTE);
                    tkeep(j) <= '1';
                else
                    tdata((j+1)*8-1 downto j*8) <= (others => '0');
                    tuser((j+1)*TUSER_BITS_PER_TDATA_BYTE-1 downto j*TUSER_BITS_PER_TDATA_BYTE) <= (others => '0');
                    tkeep(j) <= '0';
                end if;
            end loop;
            for k in 0 to TUSER_BITS_PER_TDATA_BYTE-1 loop
                tuser(k) <= txn_user_data(i*TUSER_BITS_PER_TDATA_BYTE+k);
            end loop;
            if i = txn_data'high/TDATA_BYTES then
                tlast <= '1';
            else
                tlast <= '0';
            end if;
            m_axi_handshk(
                aclk => aclk,
                ready => tready,
                valid => tvalid
            );
        end loop;
        tvalid <= '0';
        tlast <= '0';
    end procedure m_axis_txn;
    
    procedure s_axis_txn(
        signal aclk     : in    std_logic;
        signal aresetn  : in    std_logic;
        signal tready   : inout std_logic;
        signal tvalid   : in    std_logic;
        signal tdata    : in    std_logic_vector;
        signal tkeep    : in    std_logic_vector;
        signal tlast    : in    std_logic;
        signal tuser    : in    std_logic_vector;
        signal txn_data : out   byte_vector_t;
        signal txn_user_data : out std_logic_vector
      ) is
      begin
        
      end procedure s_axis_txn;
end package body easysim_axi_stream_pkg;
