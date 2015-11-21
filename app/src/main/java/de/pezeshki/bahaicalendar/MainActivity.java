/**
 *
 * Badi Calendar Android App
 * Copyright (C) 2015  Soroosh Pezeshki
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */

package de.pezeshki.bahaicalendar;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.preference.PreferenceManager;
import android.support.annotation.NonNull;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import de.pezeshki.bahaiCalendarLibrary.BadiDate;
import de.pezeshki.bahaiCalendarLibrary.BaseBadiDate;

public class MainActivity extends ActionBarActivity implements ActionBar.TabListener {

    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v4.app.FragmentStatePagerAdapter}.
     */
    SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    ViewPager mViewPager;
    ImageView structureImage;
    static String dateFormat;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SharedPreferences.OnSharedPreferenceChangeListener listener =
                new SharedPreferences.OnSharedPreferenceChangeListener() {
                    public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
                        setParameters();
                        recreate();
                    }
                };
        SharedPreferences sharedPref = PreferenceManager.getDefaultSharedPreferences(this);
        sharedPref.registerOnSharedPreferenceChangeListener(listener);
        setParameters();
        setContentView(R.layout.activity_main);
        setView();

    }

    private void setView() {
        // Set up the action bar.
        final ActionBar actionBar = getSupportActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);

        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = (ViewPager) findViewById(R.id.pager);
        mViewPager.setAdapter(mSectionsPagerAdapter);

        // When swiping between different sections, select the corresponding
        // tab. We can also use ActionBar.Tab#select() to do this if we have
        // a reference to the Tab.
        mViewPager.setOnPageChangeListener(new ViewPager.SimpleOnPageChangeListener() {
            @Override
            public void onPageSelected(int position) {
                actionBar.setSelectedNavigationItem(position);
            }
        });

        // For each of the sections in the app, add a tab to the action bar.
        for (int i = 0; i < mSectionsPagerAdapter.getCount(); i++) {
            // Create a tab with text corresponding to the page title defined by
            // the adapter. Also specify this Activity object, which implements
            // the TabListener interface, as the callback (listener) for when
            // this tab is selected.
            actionBar.addTab(
                    actionBar.newTab()
                            .setText(mSectionsPagerAdapter.getPageTitle(i))
                            .setTabListener(this));
        }
    }

    private void setParameters() {
        SharedPreferences sharedPref = PreferenceManager.getDefaultSharedPreferences(this);
        dateFormat = sharedPref.getString(SettingsActivity.KEY_PREF_DATE_FORMAT, "");
        String languageToLoad  = sharedPref.getString(SettingsActivity.KEY_PREF_LANGUAGE, "");
        Locale locale = new Locale(languageToLoad);
        Locale.setDefault(locale);
        Configuration config = new Configuration();
        config.locale = locale;
        getBaseContext().getResources().updateConfiguration(config,
                getBaseContext().getResources().getDisplayMetrics());
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            startActivity(new Intent(this, SettingsActivity.class));
            recreate();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onTabSelected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
        // When the given tab is selected, switch to the corresponding page in
        // the ViewPager.
        mViewPager.setCurrentItem(tab.getPosition());
    }

    @Override
    public void onTabUnselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    @Override
    public void onTabReselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        /**
         * getItem is called to instantiate the fragment for the given page.
         * @param position fragment position
         * @return a SectionFragment (defined as a static inner class below).
         */
        @Override
        public Fragment getItem(int position) {
            Bundle args = new Bundle();

            DisplayMetrics displaymetrics = new DisplayMetrics();
            getWindowManager().getDefaultDisplay().getMetrics(displaymetrics);

            Fragment fragment = new SectionFragment();
            args.putInt(SectionFragment.ARG_SECTION_NUMBER, position + 1);
            fragment.setArguments(args);
            return fragment;
        }

        @Override
        public int getCount() {
            // Show 3 total pages.
            return 3;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            Locale l = Locale.getDefault();
            switch (position) {
                case 0:
                    return getString(R.string.title_section1).toUpperCase(l);
                case 1:
                    return getString(R.string.title_section2).toUpperCase(l);
                case 2:
                  return getString(R.string.title_section3).toUpperCase(l);
            }
            return null;
        }
    }

    /**
     * A fragment representing a section of the app, that simply displays different tabs.
     */
    public static class SectionFragment extends Fragment {

        public static final String ARG_SECTION_NUMBER = "section_number";
        private Calendar _gregorianDate;
        String _holydays;
        String _feasts;
        String _fullDate;
        View rootView;
        int format =  "1".equals(dateFormat)?1:"2".equals(dateFormat)?2:0;

        private void setView() {
            final Calendar gregorianDate = getGregorianDate();
            if(gregorianDate!=_gregorianDate) {
                final String gregorianDateString = gregorianDateToString(gregorianDate);
                final BaseBadiDate badiDate = getBadiDate(gregorianDate);
                final String badiDateString = badiDateToString(badiDate);
                _holydays = getHolyday(badiDate);
                _feasts = getFeasts(badiDate);
                _fullDate = getFullDate(badiDate);
                ((TextView) rootView.findViewById(R.id.gregrorian_date)).setText(gregorianDateString);
                ((TextView) rootView.findViewById(R.id.badi_date)).setText(badiDateString+"\n");
                _gregorianDate=gregorianDate;
            }
            Bundle args = getArguments();
            if (args.getInt(ARG_SECTION_NUMBER) == 1) {
                ((TextView) rootView.findViewById(R.id.fragmentMain)).setText(_holydays);
            } else if (args.getInt(ARG_SECTION_NUMBER) == 2) {
                ((TextView) rootView.findViewById(R.id.fragmentMain)).setText(_feasts);
            } else if (args.getInt(ARG_SECTION_NUMBER) == 3) {
                ((TextView) rootView.findViewById(R.id.fragmentMain)).setText(_fullDate);
            }
        }

        @Override
        public void onResume() {
            super.onResume();
            // rerun when coming back from background
            setView();
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            rootView = inflater.inflate(R.layout.fragment, container, false);
            setView();
            return rootView;
        }

        /**
         * Returns the gregorian date.
         */
        @NonNull
        private Calendar getGregorianDate() {
            return new GregorianCalendar();
        }

        /**
         * Return the date as a formated string; input gregorian date as integer array.
         */
        @NonNull
        private String gregorianDateToString( @NonNull final Calendar gregotianDate ) {
            final String dateFormatString = format==0
                    ? "yyyy-MM-dd"
                    : format==1
                        ? "dd.MM.yyyy"
                        : "MM/dd/yyyy";
            final DateFormat dateFormat = new SimpleDateFormat("EEEE, "+dateFormatString);
            return dateFormat.format(gregotianDate.getTime());
        }

        /**
         * Returns the Badi date.
         */
        @NonNull
        private BaseBadiDate getBadiDate(@NonNull final Calendar calendar){
            return BadiDate.createFromGregorianCalendar(calendar);
        }

        /**
         * Return the date as a formated string; input gregorian date as integer array.
         */
        @NonNull
        private String badiDateToString( @NonNull final BaseBadiDate badiDate ) {

            final int bm = badiDate.getBadiMonth();
            final int bd = badiDate.getBadiDay();
            final int by = badiDate.getBadiYear();
            final String m0 = bm<10?"0":"";
            final String d0 = bd<10?"0":"";
            return format==0
                    ? by+"-"+m0+bm+"-"+d0+bd
                    : format==1
                        ? d0+bd+"."+m0+bm+"."+by
                        : m0+bm+"/"+d0+bd+"/"+by;
        }

        /**
         * List the first days of each month of the next 365 days.
         */
        @NonNull
        private String getFeasts(@NonNull final BaseBadiDate badiDate ){
            StringBuffer output = new StringBuffer(20*255);
            output.append(getResources().getString(R.string.titleOut1));
            output.append("\n\n");
            final int doyToday = badiDate.getBadiDayOfYear();
            final int yearToday = badiDate.getBadiYear();
            BaseBadiDate nextFeast = badiDate.getNextFeastDate();
            for (int i = 0; i < 20; i++) {
                StringBuilder entry = new StringBuilder(255);
                final int m = nextFeast.getBadiMonth();
                final String feastString = monthToString(m-1, false) + "\n" + gregorianDateToString(nextFeast.getCalendar());
                entry.append(feastString);
                // Append in how many days if less than 19
                int diff=nextFeast.getBadiDayOfYear()-doyToday;
                if ( (diff<19 && yearToday==nextFeast.getBadiYear()) ){
                    final String inDays = "\n"+ getResources().getString(R.string.in_prep) + " " + diff + " ";
                    entry.append(inDays);
                    if (diff==1) {
                        entry.append(getResources().getString(R.string.day));
                    }else{
                        entry.append(getResources().getString(R.string.days));
                    }
                }
                entry.append("\n\n");

                output = output.append(entry);
                nextFeast = nextFeast.getNextFeastDate();
            }
            return output.toString();
        }

        /**
         * List the first days of all holydays of the next 365 days.
         */
        @NonNull
        private String getHolyday(@NonNull final BaseBadiDate badiDate){
            StringBuffer output = new StringBuffer(11*255);
            output.append(getResources().getString(R.string.titleOut2));
            output.append("\n\n");
            BaseBadiDate nextHolyday = badiDate.getNextHolydayDate();
            final String[] holydayName=getResources().getStringArray(R.array.holyday);
            final int doyToday = badiDate.getBadiDayOfYear();
            for (int i = 0; i < 11; i++) {
                final Calendar gregorianDate = nextHolyday.getCalendar();
                StringBuilder entry = new StringBuilder(255);
                final String holydayString = holydayName[nextHolyday.getHolyday().getIndex()] + "\n" + badiDateToString(nextHolyday) + "\n" + gregorianDateToString(gregorianDate);
                entry.append(holydayString);
                // Append in how many days if less than 19
                int diff=nextHolyday.getBadiDayOfYear()-doyToday;
                if ( (diff<19 && badiDate.getBadiYear()==nextHolyday.getBadiYear()) ){
                    final String inDays = "\n" + getResources().getString(R.string.in_prep) + " " + diff + " ";
                    entry.append(inDays);
                    if (diff== 1) {
                        entry.append(getResources().getString(R.string.day));
                    }else{
                        entry.append(getResources().getString(R.string.days));
                    }
                }
                entry.append("\n\n");

                output = output.append(entry);
                nextHolyday = nextHolyday.getNextHolydayDate();
            }
            return output.toString();
        }


        /**
         * Returns the full Badi date and some explanation.
         */
        @NonNull
        public String getFullDate(@NonNull final BaseBadiDate badiDate) {
            StringBuilder output = new StringBuilder(2047);
            output.append(getResources().getString(R.string.titleOut3));
            output.append("\n");
            final int bm=badiDate.getBadiMonth();
            final int bd=badiDate.getBadiDay();
            final String[] arabicName = getResources().getStringArray(R.array.monthArabic);
            final String[] translatedName = getResources().getStringArray(R.array.month);
            Date date = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int weekday = cal.get(Calendar.DAY_OF_WEEK);
            String[] weekArrabic = getResources().getStringArray(R.array.weekArabic);
            String[] weekTrans = getResources().getStringArray(R.array.week);
            final int nextvahid=(badiDate.getVahid())*19+1;
            final int gregNextVahid=nextvahid+1843;
            final int nextkull=(badiDate.getKullIShay())*361+1;
            final int gregNextkull=nextkull+1843;
            String[] vahidArrabic = getResources().getStringArray(R.array.vahidArabic);
            String[] vahidTrans = getResources().getStringArray(R.array.vahid);
            final String week = weekArrabic[weekday - 1] + " (" + weekTrans[weekday - 1] + "), ";
            output.append(week);
            final String vahidString = vahidArrabic[badiDate.getYearInVahid() - 1] + " (" + vahidTrans[badiDate.getYearInVahid() - 1] + ") ";

            if(bm==19){
                output.append(vahidString);
                final String monthString = "- " + monthToString(bm-1,false) + "\n";
                output.append( monthString);
                output.append(getResources().getString(R.string.fdformatAy));
            }else {
                String monthName, dayName;
                dayName = dayToString(bd - 1);
                monthName = monthToString(bm-1, false);
                final String dateString;
                if(format==1){
                    dateString = dayName +  "." + "." + monthName + vahidString + "\n";
                }else if(format==2){
                    dateString =  monthName + "/" + dayName + "/" + vahidString + "\n";
                }else {
                    dateString = vahidString + "-" + monthName + "-" + dayName + "\n";
                }
                output.append( dateString );
                output.append( getResources().getString(R.string.fdformat) + " " +
                        getResources().getStringArray(R.array.pref_availableFormat)[format] +")");
            }
            output.append("\n\n");
            final String yearInVahid = getResources().getString(R.string.fdyearInVahid) + " " + badiDate.getYearInVahid() +"\n";
            output.append( yearInVahid );
            final String vahid = getResources().getString(R.string.fdvahid) + " " + badiDate.getVahid() + "\n";
            output.append( vahid );
            final String nVahid = getResources().getString(R.string.fdNvahid) + " " +  nextvahid + " ("+ gregNextVahid +")\n";
            output.append( nVahid );
            final String kull = getResources().getString(R.string.fdkull) + " " + badiDate.getKullIShay() + "\n";
            output.append( kull );
            final String nKull = getResources().getString(R.string.fdNkull) + " " +  nextkull + " ("+ gregNextkull +")\n\n";
            output.append( nKull );
            return output.toString() + getResources().getString(R.string.fdExplain) + "\n";
        }

        /**
         * Returns the Name of the day or month and the translation.
         */
        @NonNull
        private String monthOrDayName(final int i, final boolean hyphen){
            final String[] arabicName = getResources().getStringArray(R.array.monthArabic);
            final String[] translatedName = getResources().getStringArray(R.array.month);
            if(hyphen) {
                return arabicName[i] + " - " + translatedName[i];
            }
            return arabicName[i] + " ( " + translatedName[i] + " )";
        }

        /**
         * Return the month name and the translation.
         * bm==18: Ayyam'i'Ha; bm==19: Ala;
         */
        @NonNull
        private String monthToString(final int bm, final boolean hyphen){
            final int bi=bm+1;
            if (bm == 19) {
                return monthOrDayName(bm, hyphen) + (hyphen?" (19) ":"");
            } else if (bm == 18) {
                return monthOrDayName(bm, hyphen);
            }
            return monthOrDayName(bm, hyphen) + (hyphen?" (" + bi + ") ":"");
        }

        /**
         * Return the day name and the translation.
         */
        @NonNull
        public String dayToString(final int bd) {
            if (bd == 18) {
                return monthOrDayName(19, false);
            }
            return monthOrDayName(bd, false);
        }
    }
}
