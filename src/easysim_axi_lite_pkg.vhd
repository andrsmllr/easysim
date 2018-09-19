library ieee;
    use ieee.numeric_std.all;
    use ieee.std_logic_1164.all;

library work;
    use work.easysim_axi_common_pkg.all;

package easysim_axi_lite_pkg is
  type axil_intf_t is record
    aclk    : std_logic;
    aresetn : std_logic;
    araddr  : std_logic_vector(31 downto 0);
    arready : std_logic;
    arvalid : std_logic;
    rdata   : std_logic_vector(31 downto 0);
    rready  : std_logic;
    rvalid  : std_logic;
    rresp   : std_logic_vector(1 downto 0);
    awaddr  : std_logic_vector(31 downto 0);
    awready : std_logic;
    awvalid : std_logic;
    wdata   : std_logic_vector(31 downto 0);
    wready  : std_logic;
    wvalid  : std_logic;
    bresp   : std_logic_vector(1 downto 0);
    bready  : std_logic;
    bvalid  : std_logic;
  end record;
  
  type axil_arch_intf_t is record
    araddr  : std_logic_vector(31 downto 0);
    arready : std_logic;
    arvalid : std_logic;
  end record;
  
  type axil_rch_intf_t is record
    rdata   : std_logic_vector(31 downto 0);
    rready  : std_logic;
    rvalid  : std_logic;
    rresp   : std_logic_vector(1 downto 0);
  end record;
  
  type axil_awch_intf_t is record
    awaddr  : std_logic_vector(31 downto 0);
    awready : std_logic;
    awvalid : std_logic;
  end record;
  
  type axil_wch_intf_t is record
    wdata   : std_logic_vector(31 downto 0);
    wready  : std_logic;
    wvalid  : std_logic;
  end record;
  
  type axil_bch_intf_t is record
    bresp   : std_logic_vector(1 downto 0);
    bready  : std_logic;
    bvalid  : std_logic;
  end record;
  
  type axil_ch_intf_t is record
    arch : axil_arch_intf_t;
    rch  : axil_rch_intf_t;
    awch : axil_awch_intf_t;
    wch  : axil_wch_intf_t;
    bch  : axil_bch_intf_t;
  end record;
    
  -- Execute a single word read using the AXI-Lite protocol as a master.
  -- Improvements: allow to enable/disable reporting and control formatting of reports.
  procedure m_axil_read(
    signal aclk      : in    std_logic;
    signal aresetn   : in    std_logic;
    signal m_araddr  : out   std_logic_vector(31 downto 0);
    signal m_arready : in    std_logic;
    signal m_arvalid : inout std_logic;
    signal m_rdata   : in    std_logic_vector(31 downto 0);
    signal m_rready  : inout std_logic;
    signal m_rvalid  : in    std_logic;
    signal m_rresp   : in    std_logic_vector(1 downto 0);
    signal rdata     : out   std_logic_vector(31 downto 0);
    constant RADDR   : in    integer
  );
  
  procedure m_axil_read(
    signal m_axil    : inout axil_intf_t;
    signal rdata     : out   std_logic_vector(31 downto 0);
    constant RADDR   : in    integer
  );
  
  -- Execute a single word read using the AXI-Lite protocol as a slave.
  -- Improvements: allow to enable/disable reporting and control formatting of reports.
  procedure s_axil_read(
    signal aclk      : in    std_logic;
    signal aresetn   : in    std_logic;
    signal s_araddr  : in    std_logic_vector(31 downto 0);
    signal s_arready : inout std_logic;
    signal s_arvalid : in    std_logic;
    signal s_rdata   : out   std_logic_vector(31 downto 0);
    signal s_rready  : in    std_logic;
    signal s_rvalid  : inout std_logic;
    signal s_rresp   : out   std_logic_vector(1 downto 0);
    signal rdata     : in    std_logic_vector(31 downto 0);
    -- signal raddr     : in    integer;
    constant SENDRESP : in    axi_resp_t
  );
  
  procedure s_axil_read(
    signal s_axil    : inout axil_intf_t;
    signal rdata     : in    std_logic_vector(31 downto 0);
    -- signal raddr     : in    integer;
    constant SENDRESP : in    axi_resp_t
  );
  
  -- Execute a single word write using the AXI-Lite protocol as a master.
  -- Improvements: allow to enable/disable reporting and control formatting of reports.
  procedure m_axil_write(
    signal aclk      : in    std_logic;
    signal aresetn   : in    std_logic;
    signal m_awaddr  : out   std_logic_vector(31 downto 0);
    signal m_awready : in    std_logic;
    signal m_awvalid : inout std_logic;
    signal m_wdata   : out   std_logic_vector(31 downto 0);
    signal m_wready  : in    std_logic;
    signal m_wvalid  : inout std_logic;
    signal m_bresp   : in    std_logic_vector(1 downto 0);
    signal m_bready  : inout std_logic;
    signal m_bvalid  : in    std_logic;
    constant WADDR   : in    integer;
    constant WDATA   : in    integer;
    constant WAITRESP : in   boolean
  );
  
  procedure m_axil_write(
    signal m_axil    : inout axil_intf_t;
    constant WADDR   : in    integer;
    constant WDATA   : in    integer;
    constant WAITRESP : in   boolean
  );
  
  -- Execute a single word write using the AXI-Lite protocol as a master.
  -- Improvements: allow to enable/disable reporting and control formatting of reports.
  procedure s_axil_write(
    signal aclk       : in    std_logic;
    signal aresetn    : in    std_logic;
    signal s_awaddr   : in    std_logic_vector(31 downto 0);
    signal s_awready  : inout std_logic;
    signal s_awvalid  : in    std_logic;
    signal s_wdata    : in    std_logic_vector(31 downto 0);
    signal s_wready   : inout std_logic;
    signal s_wvalid   : in    std_logic;
    signal s_bresp    : inout std_logic_vector(1 downto 0);
    signal s_bready   : in    std_logic;
    signal s_bvalid   : inout std_logic;
    constant SENDRESP : in    axi_resp_t
  );
  
  procedure s_axil_write(
    signal s_axil     : inout axil_intf_t;
    constant SENDRESP : in    axi_resp_t
  );
end package easysim_axi_lite_pkg;


package body easysim_axi_lite_pkg is
  procedure m_axil_read(
    signal aclk      : in    std_logic;
    signal aresetn   : in    std_logic;
    signal m_araddr  : out   std_logic_vector(31 downto 0);
    signal m_arready : in    std_logic;
    signal m_arvalid : inout std_logic;
    signal m_rdata   : in    std_logic_vector(31 downto 0);
    signal m_rready  : inout std_logic;
    signal m_rvalid  : in    std_logic;
    signal m_rresp   : in    std_logic_vector(1 downto 0);
    signal rdata     : out   std_logic_vector(31 downto 0);
    constant RADDR   : in    integer
  ) is
    variable rdata_int : integer;
    variable rresp_int : integer;
  begin
    wait until (aresetn = '1') and (aresetn'event or aclk'event);
    m_araddr <= std_logic_vector(to_unsigned(RADDR, m_araddr'length));
    m_axi_handshk(
      aclk  => aclk,
      ready => m_arready,
      valid => m_arvalid
    );
    s_axi_handshk(
      aclk  => aclk,
      ready => m_rready,
      valid => m_rvalid
    );
    rdata <= m_rdata;
    rdata_int := to_integer(unsigned(m_rdata));
    report "m_axil_read: read from address @"&integer'image(RADDR)&" : "&integer'image(rdata_int);
    if (m_rresp /= AXI_RESP_OKAY_SLV) then
      report "m_axil_read: read response error "&to_string(axi_resp_slv_t'(m_rresp));
    end if;
  end procedure m_axil_read;
    
  procedure m_axil_read(
    signal m_axil    : inout axil_intf_t;
    signal rdata     : out   std_logic_vector(31 downto 0);
    constant RADDR   : in    integer
  ) is
  begin
    m_axil_read(
      aclk      => m_axil.aclk   ,
      aresetn   => m_axil.aresetn,
      m_araddr  => m_axil.araddr ,
      m_arready => m_axil.arready,
      m_arvalid => m_axil.arvalid,
      m_rdata   => m_axil.rdata  ,
      m_rready  => m_axil.rready ,
      m_rvalid  => m_axil.rvalid ,
      m_rresp   => m_axil.rresp  ,
      rdata     => rdata         ,
      RADDR     => RADDR
    );
  end procedure m_axil_read;
  
  procedure s_axil_read(
    signal aclk       : in    std_logic;
    signal aresetn    : in    std_logic;
    signal s_araddr   : in    std_logic_vector(31 downto 0);
    signal s_arready  : inout std_logic;
    signal s_arvalid  : in    std_logic;
    signal s_rdata    : out   std_logic_vector(31 downto 0);
    signal s_rready   : in    std_logic;
    signal s_rvalid   : inout std_logic;
    signal s_rresp    : out   std_logic_vector(1 downto 0);
    signal rdata      : in    std_logic_vector(31 downto 0);
    -- signal raddr      : in    integer;
    constant SENDRESP : in    axi_resp_t
  ) is
    variable araddr_int          : integer;
  begin
    wait until (aresetn = '1') and (aresetn'event or aclk'event);
    s_axi_handshk(
      aclk  => aclk,
      ready => s_arready,
      valid => s_arvalid
    );
    araddr_int := to_integer(unsigned(s_araddr));
    s_rdata <= rdata;
    s_rresp <= to_slv(SENDRESP);
    m_axi_handshk(
      aclk  => aclk,
      ready => s_rready,
      valid => s_rvalid
    );
    report "s_axil_read: read from address @"&integer'image(araddr_int)&" : "&
      integer'image(to_integer(unsigned(rdata)));
  end procedure s_axil_read;
  
  procedure s_axil_read(
    signal s_axil     : inout axil_intf_t;
    signal rdata      : in    std_logic_vector(31 downto 0);
    -- signal raddr      : in    integer;
    constant SENDRESP : in    axi_resp_t
  ) is
  begin
    s_axil_read(
      aclk      => s_axil.aclk   ,
      aresetn   => s_axil.aresetn,
      s_araddr  => s_axil.araddr ,
      s_arready => s_axil.arready,
      s_arvalid => s_axil.arvalid,
      s_rdata   => s_axil.rdata  ,
      s_rready  => s_axil.rready ,
      s_rvalid  => s_axil.rvalid ,
      s_rresp   => s_axil.rresp  ,
      rdata     => rdata         ,
      -- raddr     => raddr         ,
      SENDRESP  => SENDRESP
    );
  end procedure s_axil_read;
  
  procedure m_axil_write(
    signal aclk      : in    std_logic;
    signal aresetn   : in    std_logic;
    signal m_awaddr  : out   std_logic_vector(31 downto 0);
    signal m_awready : in    std_logic;
    signal m_awvalid : inout std_logic;
    signal m_wdata   : out   std_logic_vector(31 downto 0);
    signal m_wready  : in    std_logic;
    signal m_wvalid  : inout std_logic;
    signal m_bresp   : in    std_logic_vector(1 downto 0);
    signal m_bready  : inout std_logic;
    signal m_bvalid  : in    std_logic;
    constant WADDR   : in    integer;
    constant WDATA   : in    integer;
    constant WAITRESP : in   boolean
  ) is
    variable bresp_int : integer;
  begin
    wait until (aresetn = '1') and (aresetn'event or aclk'event);
    m_awaddr <= std_logic_vector(to_unsigned(WADDR, m_awaddr'length));
    m_axi_handshk(
      aclk  => aclk,
      ready => m_awready,
      valid => m_awvalid
    );
    m_wdata <= std_logic_vector(to_unsigned(WDATA, m_wdata'length));
    m_axi_handshk(
      aclk  => aclk,
      ready => m_wready,
      valid => m_wvalid
    );
    report "m_axil_write: write to address @"&integer'image(WADDR)&" : "&integer'image(WDATA);
    if (WAITRESP) then
      s_axi_handshk(
        aclk  => aclk,
        ready => m_bready,
        valid => m_bvalid
      );
      if (m_bresp /= AXI_RESP_OKAY_SLV) then
        report "m_axil_write: write response error "&to_string(axi_resp_slv_t'(m_bresp));
      end if;
    end if;
  end procedure m_axil_write;
  
  procedure m_axil_write(
    signal m_axil    : inout axil_intf_t;
    constant WADDR   : in    integer;
    constant WDATA   : in    integer;
    constant WAITRESP : in   boolean
  ) is
  begin
    m_axil_write(
      aclk      => m_axil.aclk,
      aresetn   => m_axil.aresetn,
      m_awaddr  => m_axil.awaddr ,
      m_awready => m_axil.awready,
      m_awvalid => m_axil.awvalid,
      m_wdata   => m_axil.wdata  ,
      m_wready  => m_axil.wready ,
      m_wvalid  => m_axil.wvalid ,
      m_bresp   => m_axil.bresp  ,
      m_bready  => m_axil.bready ,
      m_bvalid  => m_axil.bvalid ,
      WADDR     => WADDR   ,
      WDATA     => WDATA   ,
      WAITRESP  => WAITRESP
    );
  end procedure m_axil_write;
  
  procedure s_axil_write(
    signal aclk       : in    std_logic;
    signal aresetn    : in    std_logic;
    signal s_awaddr   : in    std_logic_vector(31 downto 0);
    signal s_awready  : inout std_logic;
    signal s_awvalid  : in    std_logic;
    signal s_wdata    : in    std_logic_vector(31 downto 0);
    signal s_wready   : inout std_logic;
    signal s_wvalid   : in    std_logic;
    signal s_bresp    : inout std_logic_vector(1 downto 0);
    signal s_bready   : in    std_logic;
    signal s_bvalid   : inout std_logic;
    constant SENDRESP : in    axi_resp_t
  ) is
    variable awaddr_int : integer;
    variable wdata_int  : integer;
  begin
    wait until (aresetn = '1') and (aresetn'event or aclk'event);
    s_axi_handshk(
      aclk  => aclk,
      ready => s_awready,
      valid => s_awvalid
    );
    awaddr_int := to_integer(unsigned(s_awaddr));
    s_axi_handshk(
      aclk  => aclk,
      ready => s_wready,
      valid => s_wvalid
    );
    wdata_int := to_integer(unsigned(s_wdata));
    report "s_axil_write: write to address @"&integer'image(awaddr_int)&" : "&integer'image(wdata_int);
    
    s_bresp <= to_slv(SENDRESP);
    m_axi_handshk(
      aclk  => aclk,
      ready => s_bready,
      valid => s_bvalid
    );
    report "s_axil_write: write response send "&to_string(axi_resp_slv_t'(s_bresp));
  end procedure s_axil_write;
  
  procedure s_axil_write(
    signal s_axil     : inout axil_intf_t;
    constant SENDRESP : in    axi_resp_t
  ) is
  begin
    s_axil_write(
      aclk      => s_axil.aclk,
      aresetn   => s_axil.aresetn,
      s_awaddr  => s_axil.awaddr ,
      s_awready => s_axil.awready,
      s_awvalid => s_axil.awvalid,
      s_wdata   => s_axil.wdata  ,
      s_wready  => s_axil.wready ,
      s_wvalid  => s_axil.wvalid ,
      s_bresp   => s_axil.bresp  ,
      s_bready  => s_axil.bready ,
      s_bvalid  => s_axil.bvalid ,
      SENDRESP  => SENDRESP
    );
  end procedure s_axil_write;
end package body easysim_axi_lite_pkg;
