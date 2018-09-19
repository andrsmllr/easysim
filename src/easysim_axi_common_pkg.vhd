library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;


package easysim_axi_common_pkg is
  subtype byte_t is std_logic_vector(7 downto 0);
  type byte_vector_t is array (integer range <>) of byte_t;
  
  type axi_resp_t is (OKAY, EXOKAY, SLVERR, DECERR);
  subtype axi_resp_slv_t is std_logic_vector(1 downto 0);
  constant AXI_RESP_OKAY_SLV   : axi_resp_slv_t := "00";
  constant AXI_RESP_EXOKAY_SLV : axi_resp_slv_t := "01";
  constant AXI_RESP_SLVERR_SLV : axi_resp_slv_t := "10";
  constant AXI_RESP_DECERR_SLV : axi_resp_slv_t := "11";
  constant AXI_RESP_OKAY_STRING   : string := "OKAY";
  constant AXI_RESP_EXOKAY_STRING : string := "EXOKAY";
  constant AXI_RESP_SLVERR_STRING : string := "SLVERR";
  constant AXI_RESP_DECERR_STRING : string := "DECERR";
  function to_string(resp : axi_resp_t) return string;
  function to_string(resp : axi_resp_slv_t) return string;
  function to_slv(resp : axi_resp_t) return std_logic_vector;
  
  procedure m_axi_handshk(
    signal aclk  : in    std_logic;
    signal ready : in    std_logic;
    signal valid : inout std_logic
  );
  
  procedure s_axi_handshk(
    signal aclk  : in    std_logic;
    signal ready : inout std_logic;
    signal valid : in    std_logic
  );
end package easysim_axi_common_pkg;

package body easysim_axi_common_pkg is
  function to_string(resp : axi_resp_t) return string is
  begin
    case resp is
      when OKAY   => return AXI_RESP_OKAY_STRING;
      when EXOKAY => return AXI_RESP_EXOKAY_STRING;
      when SLVERR => return AXI_RESP_SLVERR_STRING;
      when DECERR => return AXI_RESP_DECERR_STRING;
    end case;
  end function to_string;
  
  function to_string(resp : axi_resp_slv_t) return string is
  begin
    case resp is
      when AXI_RESP_OKAY_SLV   => return AXI_RESP_OKAY_STRING;
      when AXI_RESP_EXOKAY_SLV => return AXI_RESP_EXOKAY_STRING;
      when AXI_RESP_SLVERR_SLV => return AXI_RESP_SLVERR_STRING;
      when AXI_RESP_DECERR_SLV => return AXI_RESP_DECERR_STRING;
      when others              => return "INVALID";
    end case;
  end function to_string;
  
  function to_slv(resp : axi_resp_t) return std_logic_vector is
  begin
    case resp is
      when OKAY   => return AXI_RESP_OKAY_SLV;
      when EXOKAY => return AXI_RESP_EXOKAY_SLV;
      when SLVERR => return AXI_RESP_SLVERR_SLV;
      when DECERR => return AXI_RESP_DECERR_SLV;
    end case;
  end function to_slv;
  
  procedure m_axi_handshk(
    signal aclk  : in    std_logic;
    signal ready : in    std_logic;
    signal valid : inout std_logic
  ) is
    variable valid_tmp : std_logic;
  begin
    valid_tmp := valid;
    valid <= '1';
    wait until (ready and valid) = '1' and rising_edge(aclk);
    valid <= valid_tmp;
  end procedure m_axi_handshk;
  
  procedure s_axi_handshk(
    signal aclk  : in    std_logic;
    signal ready : inout std_logic;
    signal valid : in    std_logic
  ) is
    variable ready_tmp : std_logic;
  begin
    ready_tmp := ready;
    ready <= '1';
    wait until (ready and valid) = '1' and rising_edge(aclk);
    ready <= ready_tmp;
  end procedure s_axi_handshk;
end package body easysim_axi_common_pkg;
