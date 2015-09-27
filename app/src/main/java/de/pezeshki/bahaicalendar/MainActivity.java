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
import java.util.Locale;

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
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;


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

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

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


//    @Override
//    public boolean onCreateOptionsMenu(Menu menu) {
//        // Inflate the menu; this adds items to the action bar if it is present.
//        getMenuInflater().inflate(R.menu.menu_main, menu);
//        return true;
//    }
//
//    @Override
//    public boolean onOptionsItemSelected(MenuItem item) {
//        // Handle action bar item clicks here. The action bar will
//        // automatically handle clicks on the Home/Up button, so long
//        // as you specify a parent activity in AndroidManifest.xml.
//        int id = item.getItemId();
//
//        //noinspection SimplifiableIfStatement
//        if (id == R.id.action_settings) {
//            return true;
//        }
//
//        return super.onOptionsItemSelected(item);
//    }

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
//            int height = displaymetrics.heightPixels;
//            int width = displaymetrics.widthPixels;

            Fragment fragment = new SectionFragment();
            args.putInt(SectionFragment.ARG_SECTION_NUMBER, position + 1);
//            args.putInt(SectionFragment.dispH, height);
//            args.putInt(SectionFragment.dispW, width);
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

//    public static final String ARG_SECTION_NUMBER = "section_number";
//    public void showFigure(View view) {
        // change view on click
//        Bundle args = getArguments();
//        if (args.getInt(ARG_SECTION_NUMBER)==3) {
//            Intent intent = new Intent(this, DisplayFigureActivity.class);
//            startActivity(intent);
//        }
//    }

    /**
     * A fragment representing a section of the app, that simply displays different tabs.
     */
    public static class SectionFragment extends Fragment {

        public static final String ARG_SECTION_NUMBER = "section_number";
        private int[] _gregorianDate;
        String _holydays;
        String _feasts;
        String _fullDate;
        //        public static final String dispW = "display Width";
        View rootView;


        private void setView() {
            final int[] gregorianDate = getGregorianDate();
            if(gregorianDate!=_gregorianDate) {
                final String gregorianDateString = gregorianDateToString(gregorianDate);
                final int[] badiDate = getBadiDate(gregorianDate);
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
        private int[] getGregorianDate() {
            final Date date = new Date();
            final Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            final int year = cal.get(Calendar.YEAR);
            final int month = cal.get(Calendar.MONTH)+1;
            final int day = cal.get(Calendar.DAY_OF_MONTH);
            final int doy = cal.get(Calendar.DAY_OF_YEAR);
            return new int[] {year, month, day, doy};
        }

        /**
         * Return the date as a formated string; input gregorian date as integer array.
         */
        @NonNull
        private String gregorianDateToString( @NonNull final int[] gregotianDate ) {
            final DateFormat dateFormat = new SimpleDateFormat("EEEE, yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.DAY_OF_MONTH, gregotianDate[2]);
            calendar.set(Calendar.MONTH, gregotianDate[1]-1);
            calendar.set(Calendar.YEAR, gregotianDate[0]);
            return dateFormat.format(calendar.getTime());
        }

        /**
         * Returns the Badi date.
         */
        @NonNull
        private int[] getBadiDate(@NonNull final int[] gregorianDate){
            return Badi.Gregorian2Badi(gregorianDate[0], gregorianDate[1], gregorianDate[2]);
        }

        /**
         * Return the date as a formated string; input gregorian date as integer array.
         */
        @NonNull
        private String badiDateToString( @NonNull final int[] badiDate ) {
            return badiDate[0]+"-"+badiDate[1]+"-"+badiDate[2];
        }

        /**
         * List the first days of each month of the next 365 days.
         */
        @NonNull
        private String getFeasts(@NonNull final int[] badiDate ){
            String output = getResources().getString(R.string.titleOut1)+"\n\n";
            final int doyToday = badiDate[3];
            final int yearToday = badiDate[0];
            final int monthToday = badiDate[1];
            for (int i = monthToday; i < 20+monthToday; i++) {
                final int m=i%20+1;
                final int year = i>19?yearToday+1:yearToday;
                final int[] badiNext = {year,m, 1};
                final int[] dateNext = Badi.Badi2Gregorian(year,m,1);
                String entry = monthToString(m-1) + "\n" + gregorianDateToString(dateNext) + "\n";
                int diff=m*19-doyToday;
                if ( (diff<19 && yearToday==dateNext[0]) ){
                    if (diff==1) {
                        entry = entry.concat(getResources().getString(R.string.in_prep) +" "+ diff  +" "+ getResources().getString(R.string.day)+"\n\n");
                    }else{
                        entry = entry.concat(getResources().getString(R.string.in_prep) +" "+ diff  +" "+ getResources().getString(R.string.days)+"\n\n");
                    }
                }else{
                    entry = entry.concat("\n");
                }
                output = output.concat(entry);
            }
            return output;
        }

        /**
         * List the first days of all holydays of the next 365 days.
         */
        @NonNull
        private String getHolyday(@NonNull final int[] badiDate){
            String output = getResources().getString(R.string.titleOut2)+"\n\n";
            int[] date = badiDate;
            final String[] holydayName=getResources().getStringArray(R.array.holyday);
            final int doyToday = badiDate[3];
            for (int i = 0; i < 11; i++) {
                final int[] dateNext = Badi.getNextHolydayBadiDate(date[0], date[1], date[2]);
                final int[] gregorianDate = Badi.Badi2Gregorian(dateNext[0], dateNext[1], dateNext[2]);
                String entry =  holydayName[dateNext[4]] + "\n" + badiDateToString(dateNext) + "\n"
                        + gregorianDateToString(gregorianDate) + "\n";
                int diff=dateNext[3]-doyToday;
                if ( (diff<19 && badiDate[0]==dateNext[0]) ){
                    if (diff==1) {
                        entry = entry.concat( getResources().getString(R.string.in_prep) +" "+ diff  +" "+ getResources().getString(R.string.day)+"\n\n");
                    }else{
                        entry = entry.concat( getResources().getString(R.string.in_prep) +" "+ diff  +" "+ getResources().getString(R.string.days)+"\n\n");
                    }
                }else{
                    entry = entry.concat( "\n");
                }
                output = output.concat(entry);
                date = dateNext;
            }
            return output;
        }


        /**
         * Returns the full Badi date and some explanation.
         */
        @NonNull
        public String getFullDate(@NonNull final int[] badiDate) {
            String output = getResources().getString(R.string.titleOut3)+"\n";;
            final int bm=badiDate[1];
            final int bd=badiDate[2];
            final String[] arabicName = getResources().getStringArray(R.array.monthArabic);
            final String[] translatedName = getResources().getStringArray(R.array.month);
            Date date = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int weekday = cal.get(Calendar.DAY_OF_WEEK);
            String[] weekArrabic = getResources().getStringArray(R.array.weekArabic);
            String[] weekTrans = getResources().getStringArray(R.array.week);
            final int nextvahid=(badiDate[6])*19+1;
            final int gregNextVahid=nextvahid+1843;
            final int nextkull=(badiDate[7])*361+1;
            final int gregNextkull=nextkull+1843;
            String[] vahidArrabic = getResources().getStringArray(R.array.vahidArabic);
            String[] vahidTrans = getResources().getStringArray(R.array.vahid);
            output = output.concat( weekArrabic[weekday-1] + " ("+ weekTrans[weekday-1] +"), ");
            output = output.concat( vahidArrabic[badiDate[5]-1] + " (" + vahidTrans[badiDate[5]-1] + ")- ");

            if(bm==19){
                output = output.concat( arabicName[bm - 1] + " (" + translatedName[bm - 1] + ")\n");
                output = output.concat( getResources().getString(R.string.fdformatAy) +"\n\n");
            }else {
                String monthName, dayName;
                dayName = dayToString(bd - 1) + "\n";
                monthName = arabicName[bm - 1] + " (" + translatedName[bm - 1] + ")";
                output = output.concat( monthName+"-"+dayName);
                output = output.concat( getResources().getString(R.string.fdformat) +"\n\n");
            }
            output = output.concat( getResources().getString(R.string.fdyearInVahid) + " " + badiDate[5] +"\n");
            output = output.concat( getResources().getString(R.string.fdvahid) +" "+  badiDate[6]+"\n");
            output = output.concat( getResources().getString(R.string.fdNvahid) +" "+  nextvahid + " ("+ gregNextVahid +")\n");
            output = output.concat( getResources().getString(R.string.fdkull) +" "+  badiDate[7] +"\n");
            output = output.concat( getResources().getString(R.string.fdNkull) +" "+  nextkull + " ("+ gregNextkull +")\n\n");
            output = output.concat( getResources().getString(R.string.fdExplain) + "\n");
            return output;
        }

        /**
         * Returns the Name of the day or month and the translation.
         */
        @NonNull
        private String monthOrDayName(final int i){
            final String[] arabicName = getResources().getStringArray(R.array.monthArabic);
            final String[] translatedName = getResources().getStringArray(R.array.month);
            return arabicName[i] + " - " + translatedName[i];
        }

        /**
         * Return the month name and the translation.
         * bm==18: Ayyam'i'Ha; bm==19: Ala;
         */
        @NonNull
        private String monthToString(final int bm){
            final int bi=bm+1;
            if (bm == 19) {
                return monthOrDayName(bm) + " (19) ";
            } else if (bm == 18) {
                return monthOrDayName(bm);
            }
            return monthOrDayName(bm) + " (" + bi + ") ";
        }

        /**
         * Return the day name and the translation.
         */
        @NonNull
        public String dayToString(final int bd) {
            if (bd == 18) {
                return monthOrDayName(19);
            }
            return monthOrDayName(bd);
        }
    }
}
