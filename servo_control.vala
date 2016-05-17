/*-------------By Alvaro Bravo @ alvaroubravo@gmail.com--------------*/

/* The following program is in charge of setting up the connection
/* with the Pololu Maestro Servo via a Serial connection and setting the positions
/* each of the servo-motors should */

class Komms : Object {
  // POLOLU SERVO MASTER TAGS
  public const uint8 UART_DBR = 0xAA;
  public const uint8 SET_TARGET= 0x04;
  public const uint8 SET_SPEED = 0x07;
  public const uint8 SET_ACCEL = 0x09;

  public uint8 device {get; set; default=0x0C;}
  private int fd;
  private Posix.termios options;

  uint8 least_significant (int number){
    int least_ = number & 0x7F;
    return (uint8)least_;
  }
  uint8 most_significant (int number){
    int most_ = (number >> 7) & 0x7F;
    return (uint8)most_;
  }

  public bool startKomms (string dev="/dev/rfcomm0"){
    this.fd = Posix.open(dev, Posix.O_RDWR | Posix.O_NOCTTY);
    if (this.fd == -1) return false;

    Posix.tcgetattr( this.fd, out this.options );
    this.options.c_lflag &= ~( Posix.ECHO | Posix.ECHONL | Posix.ICANON | Posix.ISIG | Posix.IEXTEN);
    this.options.c_oflag &= ~( Posix.ONLCR | Posix.OCRNL);
    Posix.tcsetattr( this.fd, Posix.TCSANOW, this.options);

    return true;
  }

  //This two functions set one or multiple servos to the desired position
  public bool setTarget (int channel, int target){

    uint8[] targetPosition = {
      UART_DBR,
      this.device,
      SET_TARGET,
      (uint8)channel,
      this.least_significant(target*4),
      this.most_significant(target*4)};

    if (Posix.write(this.fd,targetPosition,targetPosition.length)==-1) return false;

    return true;
  }

  public bool setTargets(int[] targets){

    for (int i=0;i<targets.length;i++){

      uint8[] targetPositions = {
        UART_DBR,
        this.device,
        SET_TARGET,
        (uint8)i,
        this.least_significant(targets[i]*4),
        this.most_significant(targets[i]*4)};

      if (Posix.write(this.fd,targetPositions,targetPositions.length)==-1) return false;
    }

    return true;
  }
  //This two functions set the speed at which a servo, or a set, will change its position
  public bool setSpeed (int channel, int speed){

    uint8[] targetSpeed = {
      UART_DBR,
      this.device,
      SET_SPEED,
      (uint8)channel,
      this.least_significant(speed),
      this.most_significant(speed)};

    if (Posix.write(this.fd,targetSpeed,targetSpeed.length)==-1) return false;

    return true;
  }

  public bool setSpeeds (int[] speeds){

    for (int i=0;i<speeds.length;i++){

      uint8[] targetSpeeds = {
        UART_DBR,
        this.device,
        SET_SPEED,
        (uint8)i,
        this.least_significant(speeds[i]),
        this.most_significant(speeds[i])};

      if (Posix.write(this.fd,targetSpeeds,targetSpeeds.length)==-1) return false;
    }

    return true;
  }
  //This two functions set the rate at which a servo, or a set, will speed up to change its position
  public bool setAccel (int channel, int accel){

    uint8[] targetAccel = {
      UART_DBR,
      this.device,
      SET_SPEED,
      (uint8)channel,
      this.least_significant(accel),
      this.most_significant(accel)};

    if (Posix.write(this.fd,targetAccel,targetAccel.length)==-1) return false;

    return true;
  }
  public bool setAccels (int[] accels){

        for (int i=0;i<accels.length;i++){

          uint8[] targetAccels = {
            UART_DBR,
            this.device,
            SET_ACCEL,
            (uint8)i,
            this.least_significant(accels[i]),
            this.most_significant(accels[i])};

          if (Posix.write(this.fd,targetAccels,targetAccels.length)==-1) return false;
        }

        return true;
  }
}
