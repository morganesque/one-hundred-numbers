package com.commonagency 
{
	public class cDate 
	{
	    public static var long_months:Vector.<String> = Vector.<String>(['january','february','march','april','may','june','july','august','september','october','november','december']);
        public static var short_months:Vector.<String> = Vector.<String>(['jan','feb','mar','apr','may','jun','jul','aug','sept','oct','nov','dec']);
        public static var long_days:Vector.<String> = Vector.<String>(['sunday','monday','tuesday','wednesday','thursday','friday','saturday']);
        public static var short_days:Vector.<String> = Vector.<String>(['sun','mon','tues','wed','thur','fri','sat']);
        public static var month_days:Vector.<uint> = Vector.<uint>([31,28,31,30,31,30,31,31,30,31,30,31]);
        public static var suffixes:Vector.<String> = Vector.<String>(['th','st','nd','rd']);
        public static var one_day:uint = 86400000; // one day in milliseconds.
	    
        public static function findLastYearMonthWeekDay(year,month,weekday):Date
        {
            var now = new Date();
            if (now.fullYear > year)
            {
                now.fullYear = year;
                now.month = month;
                now.date = 31;
            }
            while(now.day != weekday)
            {
                now.time -= one_day;
            }
            return now;
        }
        
        public static function findLastYearWeekDay(year,weekday):Date
        {
            var now = new Date();
            if (now.fullYear > year)
            {
                now.fullYear = year;
                now.month = 11;
                now.date = 31;
            }
            while(now.day != weekday)
            {
                now.time -= one_day;
            }
            return now;
        }
        
        public static function findLastMonthWeekDay(month,weekday):Date
        {
            var now = new Date();
            if (month > now.month) now.fullYear--;
            now.month = month;
            now.date = month_days[month];
            while(now.day != weekday)
            {
                now.time -= one_day;
            }
            return now;
        }
        
        public static function halellujah(day,month,year):Date
        {
            return new Date(year, month, day);
        }
        
        public static function findLastWeekDay(weekday):Date
        {
            trace("parsedDate::findLastWeekDay() - ");
            var now = new Date();
            while(now.day != weekday)
            {
                now.time -= one_day;
            }
            return now;            
        }
        
        public static function findLastDay(day):Date
        {
            var now = new Date();
            while(now.date != day)
            {
                now.time -= one_day;
            }
            return now;
        }
        
        public static function findLastDayMonth(day,month):Date
        {        
            var now = new Date();
            if (month > now.month) now.fullYear--;
            if (month == now.month && day > now.date) now.fullYear--;
            
            var dow = new Date(now.fullYear, month, day);
            /*
            while(dow.date != day)
            {
                dow.time -= one_day;
            }
            */
            return dow;
        }
        
        public static function findLastDayYear(day,year):Date
        {
            var now = new Date();
            if (now.fullYear > year)
            {
                now.fullYear = year;
                now.month = 11;
                now.date = 31;
            }
            while(now.date != day)
            {
                now.time -= one_day;
            }
            return now;
        }
        
        public static function monthDays(month:uint, year:uint=1):uint
        {
            if (month == 1 && year%4 == 0) return 29;
            else return month_days[month];
        }
	}
}

