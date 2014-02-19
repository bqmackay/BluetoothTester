//
//  Constants.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

static const NSString *dataFromStringUUID = @"00eff2b2-e420-4d23-9bdd-802af59aeb6f";
static const NSString *dataToStringUUID = @"a886c7ec-31ee-48d6-9aa8-35291b21780f";

static const NSString *myLifterServiceUUID = @"56d5862a-0899-4eeb-a5a7-af43c5ccf11e";

//SYSTEM COMMANDS
static const char *COMMAND_NACK = "\x00";
static const char *COMMAND_ACK = "\x01";
static const char *COMMAND_GET_VDT = "\x02";
static const char *COMMAND_PK = "\x03";
static const char *COMMAND_PING = "\x04";               static const int PERIPHERAL_COMMAND_PING = 16;
static const char *COMMAND_BLANK = "\x08";

static const char *COMMAND_CONN_STAT = "\x05";
static const char *COMMAND_CLEAR_ERROR = "\x06";

//CONTROL COMMANDS
static const char *COMMAND_STOP = "\x10";               static const int PERIPHERAL_COMMAND_STOP = 0;
static const char *COMMAND_TOP = "\x11";                static const int PERIPHERAL_COMMAND_TOP = 1;
static const char *COMMAND_BOTTOM = "\x12";             static const int PERIPHERAL_COMMAND_BOTTOM = 2;
static const char *COMMAND_ZERO = "\x20";               static const int PERIPHERAL_COMMAND_ZERO = 3;
static const char *COMMAND_UP = "\x21";                 static const int PERIPHERAL_COMMAND_UP = 4;
static const char *COMMAND_DOWN = "\x22";               static const int PERIPHERAL_COMMAND_DOWN = 5;
static const char *COMMAND_SYNC = "\x23";               static const int PERIPHERAL_COMMAND_SYNC = 6;

//STATUS COMMANDS
static const char *COMMAND_ERROR = "\x30";              static const int PERIPHERAL_COMMAND_ERROR = 7;
static const char *COMMAND_DEBUG = "\x31";              static const int PERIPHERAL_COMMAND_DEBUG = 8;

//LINKED LIFT COMMANDS
static const char *COMMAND_LINK_INFO_GET = "\x40";      static const int PERIPHERAL_COMMAND_GET_LINK_INFO = 13;
static const char *COMMAND_LINK_INFO_SET = "\x41";      static const int PERIPHERAL_COMMAND_SET_LINK_INFO = 14;
static const char *COMMAND_LINK_ITEM_GET = "\x42";      static const int PERIPHERAL_COMMAND_GET_LINK_ITEM = 11;
static const char *COMMAND_LINK_ITEM_SET = "\x43";      static const int PERIPHERAL_COMMAND_SET_LINK_ITEM = 12;

//CALIBRATION COMMANDS
static const char *COMMAND_CAL_ZERO = "\xF0";           static const int PERIPHERAL_COMMAND_CAL_ZERO = 99;
static const char *COMMAND_CAL_TOP = "\xF1";            static const int PERIPHERAL_COMMAND_CAL_TOP = 9;
static const char *COMMAND_CAL_BOTTOM = "\xF2";         static const int PERIPHERAL_COMMAND_CAL_BOTTOM = 10;

static const char *COMMAND_LIFT_CYCLE = "\xFF";         static const int PERIPHERAL_COMMAND_LIFE_CYCLE = 15;


#endif
