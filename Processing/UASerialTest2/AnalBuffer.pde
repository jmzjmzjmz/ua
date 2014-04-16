class AnalBuffer {
    
  public Serial serial;
  public final int x;
  public final int y;

  public final int[][] order;

  public final int length;
  public final int id;

  AnalBuffer(int id, PApplet p, String serialID, int x, int y, int[][] order) {
    
    this.serial = new Serial(p, serialID, BAUD);
    this.serial.bufferUntil(13);
    this.id = id;
    this.x = x;
    this.y = y;
    this.order = order;
    this.length = this.order.length;
    println(this.length);
  }



}
