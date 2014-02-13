//
//  Constants.h
//  BlueToothTesting
//
//  Created by Byron Mackay on 2/13/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

const NSString *dataFromStringUUID = @"00eff2b2-e420-4d23-9bdd-802af59aeb6f";
const NSString *dataToStringUUID = @"a886c7ec-31ee-48d6-9aa8-35291b21780f";

//SYSTEM COMMANDS
const char *COMMAND_NACK = "\x00";
const char *COMMAND_ACK = "\x01";
const char *COMMAND_GET_VDT = "\x02";
const char *COMMAND_PING = "\x03";
const char *COMMAND_PK = "\x04";
const char *COMMAND_BLANK = "\x08";

const char *COMMAND_CONN_STAT = "\x05";
const char *COMMAND_CLEAR_ERROR = "\x06";

//CONTROL COMMANDS
const char *COMMAND_STOP = "\x10";
const char *COMMAND_TOP = "\x11";
const char *COMMAND_BOTTOM = "\x12";
const char *COMMAND_ZERO = "\x20";
const char *COMMAND_UP = "\x21";
const char *COMMAND_DOWN = "\x22";
const char *COMMAND_SYNC = "\x23";

//STATUS COMMANDS
const char *COMMAND_ERROR = "\x30";
const char *COMMAND_DEBUG = "\x31";

//LINKED LIFT COMMANDS
const char *COMMAND_LINK_INFO_GET = "\x40";
const char *COMMAND_LINK_INFO_SET = "\x41";
const char *COMMAND_LINK_ITEM_GET = "\x42";
const char *COMMAND_LINK_ITEM_SET = "\x43";

//CALIBRATION COMMANDS
const char *COMMAND_CAL_ZERO = "\xF0";
const char *COMMAND_CAL_TOP = "\xF1";
const char *COMMAND_CAL_BOTTOM = "\xF2";

const char *COMMAND_LIFT_CYCLE = "\xFF";


#endif
