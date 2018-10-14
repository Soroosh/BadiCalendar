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
import java.text.NumberFormat;
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
import android.support.v7.app.ActionBar;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import de.pezeshki.bahaiCalendarLibrary.BadiDate;
import de.pezeshki.bahaiCalendarLibrary.BahaiHolyday;
import de.pezeshki.bahaiCalendarLibrary.BaseBadiDate;

public class MainActivity extends AppCompatActivity implements ActionBar.TabListener {

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
    static Locale locale;
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
        locale = new Locale(languageToLoad);
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
            final NumberFormat nf = NumberFormat.getInstance(locale);
            nf.setGroupingUsed(false);
            if(gregorianDate!=_gregorianDate) {
                final String gregorianDateString = gregorianDateToString(gregorianDate);
                final BaseBadiDate badiDate = getBadiDate(gregorianDate);
                final String badiDateString = badiDateToString(badiDate, nf);
                _holydays = getHolyday(badiDate, nf);
                _feasts = getFeasts(badiDate, nf);
                _fullDate = getFullDate(badiDate, nf);
                ((TextView) rootView.findViewById(R.id.gregrorian_date)).setText(gregorianDateString);
                ((TextView) rootView.findViewById(R.id.badi_date)).setText(badiDateString);

                // If today is a holy day, write below the date
                final BahaiHolyday holydayToday = badiDate.getHolyday();
                if(holydayToday!=null) {
                    final String[] holydayName = getResources().getStringArray(R.array.holyday);
                    ((TextView) rootView.findViewById(R.id.holiday_today)).setText(String.format("\n%s\n",holydayName[holydayToday.getIndex()]));
                }else {
                    ((TextView) rootView.findViewById(R.id.holiday_today)).setText("\n");
                }
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
            final String separator = getResources().getStringArray(R.array.format_separator)[format];
            final String dateFormatString = format==0
                    ? "yyyy"+separator+"MM"+separator+"dd"
                    : format==1
                        ? "dd"+separator+"MM"+separator+"yyyy"
                        : "MM"+separator+"dd"+separator+"yyyy";
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
        private String badiDateToString( @NonNull final BaseBadiDate badiDate, @NonNull NumberFormat nf ) {

            final int bm = badiDate.getBadiMonth();
            final int bd = badiDate.getBadiDay();
            final String separator = getResources().getStringArray(R.array.format_separator)[format];
            final String by = nf.format(badiDate.getBadiYear());
            final String m0 = bm<10 ? nf.format(0) : "";
            final String month = (bm == 20)
                    ? nf.format(19)
                    : String.format("%s%s", m0, nf.format(bm));
            final String d0 = bd<10 ? nf.format(0) : "";
            final String day = String.format("%s%s",d0,nf.format(bd));
            final String first;
            final String second;
            final String third;
            if(format==1){
                first=day;
                second=month;
                third=by;
            }else if(format==2){
                first=month;
                second=day;
                third=by;
            }else{
                first=by;
                second=month;
                third=day;
            }
            // Ayyam'i'Ha
            if(bm==19){
                return format==0
                        ? by+"-"+getString(R.string.ayyamIHa)
                        : getString(R.string.ayyamIHa)+" "+by;
            }
            return String.format("%s%s%s%s%s", first, separator, second, separator, third);
        }

        /**
         * List the first days of each month of the next 365 days.
         */
        @NonNull
        private String getFeasts(@NonNull final BaseBadiDate badiDate, @NonNull final NumberFormat nf ){
            StringBuffer output = new StringBuffer(20*255);
            output.append(getResources().getString(R.string.titleOut1));
            output.append("\n\n");
            BaseBadiDate nextFeast = badiDate.getNextFeastDate();
            for (int i = 0; i < 20; i++) {
                StringBuilder entry = new StringBuilder(255);
                final int m = nextFeast.getBadiMonth();
                final String feastString = monthToString(m-1, false) + "\n" + gregorianDateToString(nextFeast.getCalendar());
                entry.append(feastString);
                 // Append in how many days if less than 19
                if(i==0||(i==1&&nextFeast.getBadiMonth()==20)){
                    int diff=20-badiDate.getBadiDay();
                    // Special case Ayyam-i-Ha
                    if(nextFeast.getBadiMonth()==20){
                        diff=nextFeast.getBadiDayOfYear()-badiDate.getBadiDayOfYear();
                    }
                    final String inDays = String.format("\n%s %s ", getResources().getString(R.string.in_prep), nf.format(diff));
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
        private String getHolyday(@NonNull final BaseBadiDate badiDate, @NonNull final NumberFormat nf){
            StringBuffer output = new StringBuffer(11*255);
            output.append(getResources().getString(R.string.titleOut2));
            output.append("\n\n");
            BaseBadiDate nextHolyday = badiDate.getNextHolydayDate();
            final String[] holydayName=getResources().getStringArray(R.array.holyday);
            final int doyToday = badiDate.getBadiDayOfYear();
            for (int i = 0; i < 11; i++) {
                final Calendar gregorianDate = nextHolyday.getCalendar();
                StringBuilder entry = new StringBuilder(255);
                final String holydayString = String.format("%s\n%s\n%s",holydayName[nextHolyday.getHolyday().getIndex()], badiDateToString(nextHolyday, nf),gregorianDateToString(gregorianDate));
                entry.append(holydayString);
                // Append in how many days if less than 19
                int diff=nextHolyday.getBadiDayOfYear()-doyToday;
                // Special case Naw-Ruz
                if(i==0&&nextHolyday.getBadiMonth()==1){
                    diff=20-badiDate.getBadiDay();
                }
                if ( (diff>0&&diff<20) ){
                    final String inDays = String.format("\n%s %s ",getResources().getString(R.string.in_prep), nf.format(diff));
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
        public String getFullDate(@NonNull final BaseBadiDate badiDate, @NonNull final NumberFormat nf) {

            final String separator = getResources().getStringArray(R.array.format_separator)[format];
            StringBuilder output = new StringBuilder(2047);
            output.append(getResources().getString(R.string.titleOut3));
            output.append("\n");
            final int bm=badiDate.getBadiMonth();
            final int bd=badiDate.getBadiDay();
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
            final String weekTranslation = weekTrans[weekday - 1].length()>0 ?String.format(" (%s)", weekTrans[weekday - 1]) :"";
            final String week = String.format("%s%s,", weekArrabic[weekday - 1], weekTranslation);
            output.append(week);
            String vahidTran = vahidTrans[badiDate.getYearInVahid() - 1];
            final String vahidString;
            if(vahidTran.length()<1){
                vahidString = vahidArrabic[badiDate.getYearInVahid() - 1];
            } else {
                vahidString = String.format("%s (%s) ",vahidArrabic[badiDate.getYearInVahid() - 1], vahidTran);
            }
            if(bm==19){
                output.append(vahidString);
                final String monthString = String.format("- %s\n", monthToString(bm-1,false));
                output.append( monthString );
                output.append(getResources().getString(R.string.fdformatAy));
            }else {
                String monthName, dayName;
                dayName = dayToString(bd - 1);
                monthName = monthToString(bm-1, false);
                final String dateString;
                if(format==1){
                    dateString = dayName +  separator + monthName + separator + vahidString + "\n";
                }else if(format==2){
                    dateString =  monthName + separator + dayName + separator + vahidString + "\n";
                }else {
                    dateString = vahidString + separator + monthName + separator + dayName + "\n";
                }
                output.append( dateString );
                output.append( String.format("(%s %s)", getResources().getString(R.string.fdformat),
                        getResources().getStringArray(R.array.pref_availableFormat)[format]));
            }
            output.append("\n\n");
            final String yearInVahid = String.format("%s %s\n", getResources().getString(R.string.fdyearInVahid), nf.format(badiDate.getYearInVahid()));
            output.append( yearInVahid );
            final String vahid = String.format("%s %s\n", getResources().getString(R.string.fdvahid), nf.format(badiDate.getVahid()));
            output.append( vahid );
            final String nVahid = String.format("%s %s (%s)\n", getResources().getString(R.string.fdNvahid),  nf.format(nextvahid), nf.format(gregNextVahid));
            output.append( nVahid );
            final String kull = String.format("%s %s\n", getResources().getString(R.string.fdkull), nf.format(badiDate.getKullIShay()));
            output.append( kull );
            final String nKull = String.format("%s %s (%s)\n\n", getResources().getString(R.string.fdNkull), nf.format(nextkull), nf.format(gregNextkull));
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
            if(translatedName[i].length()<1){
                return arabicName[i];
            }
            if(hyphen) {
                return String.format("%s - %s", arabicName[i], translatedName[i]);
            }
            return String.format("%s (%s)", arabicName[i], translatedName[i]);
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
            return monthOrDayName(bm, hyphen) + (hyphen? String.format(" (%s)", bi) :"");
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
