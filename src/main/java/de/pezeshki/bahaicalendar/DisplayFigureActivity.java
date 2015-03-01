package de.pezeshki.bahaicalendar;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Point;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Display;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import java.util.Calendar;
import java.util.Date;

import de.pezeshki.bahaicalendar.R;

public class DisplayFigureActivity extends ActionBarActivity {

    /** Called when the activity is first created. */
    Paint mPaint;
    float Mx1,My1;
    float x,y;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        Intent intent = getIntent();
//        // Set the text view as the activity layout
//        TextView textView = new TextView(this);
//        setContentView(textView);
        MyView view1 =new MyView(this);
        view1.setBackgroundResource(R.drawable.untitled);
        setContentView(view1);


        mPaint = new Paint();
        mPaint.setAntiAlias(true);
        mPaint.setDither(true);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeJoin(Paint.Join.ROUND);
        // mPaint.setStrokeCap(Paint.Cap.ROUND);
        mPaint.setStrokeWidth(10);
    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public class MyView extends View {

        private static final float MINP = 0.25f;
        private static final float MAXP = 0.75f;

        private Bitmap mBitmap;
        private Canvas mCanvas;
        private Path mPath;
        private Paint   mBitmapPaint;

        public MyView(Context c) {
            super(c);

            mPath = new Path();
            mBitmapPaint = new Paint(Paint.DITHER_FLAG);
        }

        @Override
        protected void onSizeChanged(int w, int h, int oldw, int oldh) {
            super.onSizeChanged(w, h, oldw, oldh);
            mBitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
            mCanvas = new Canvas(mBitmap);
        }

        @Override
        protected void onDraw(Canvas canvas) {
            canvas.drawColor(0xFFFFFFFF);

            Display display = getWindowManager().getDefaultDisplay();
            Point size = new Point();
            display.getSize(size);
            int width = size.x;
            int height = size.y;
            String text;
            float x=width*0.5f ,y=0.0f, textsize=64.0f;

            int minX=50, maxX=width-50;


            text=getResources().getString(R.string.fdkull);
            // canvas.drawLine(mX, mY, Mx1, My1, mPaint);
            // canvas.drawLine(mX, mY, x, y, mPaint);
            canvas.drawBitmap(mBitmap, 0, 0, mBitmapPaint);
            canvas.drawPath(mPath, mPaint);
            mPath.reset();
            mPaint.setColor(0xFF000000);
            mPath.moveTo(minX, 100);
            mPath.lineTo(maxX, 100);
            mPaint.setTextSize(textsize);
//            mPaint.setTextSize(16);
            // commit the path to our offscreen
            mCanvas.drawPath(mPath, mPaint);
            mCanvas.drawTextOnPath(text,mPath,x,y, mPaint);

        }

    }
}
