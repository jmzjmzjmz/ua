class AnalBuffer {
    
  public Serial serial;
  public int x;
  public int y;

  public int[][] order;

  public int length;

  AnalBuffer(PApplet p, String serialID, int x, int y, int[][] order) {
    
    // this.serial = new Serial(p, serialID, BAUD);
    // this.serial.bufferUntil(13);

    this.x = x;
    this.y = y;
    this.order = order;
    this.length = this.order.length;

  }

}