package com.pojo;
import javax.persistence.*;
@Entity
@Table(name = "places")
public class Places {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "place1")
    private String place1;

    @Column(name = "place2")
    private String place2;

    @Column(name = "place3")
    private String place3;

    @Column(name = "place4")
    private String place4;

    @Column(name = "time1")
    private String time1;

    @Column(name = "time2")
    private String time2;

    @Column(name = "time3")
    private String time3;

    @Column(name = "time4")
    private String time4;

    @Column(name = "max_seats")
    private int maxSeats;

    @OneToOne
    @JoinColumn(name = "movie_id", referencedColumnName = "id")
    private MovieDetails movieDetails;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlace1() {
        return place1;
    }

    public void setPlace1(String place1) {
        this.place1 = place1;
    }

    public String getPlace2() {
        return place2;
    }

    public void setPlace2(String place2) {
        this.place2 = place2;
    }

    public String getPlace3() {
        return place3;
    }

    public void setPlace3(String place3) {
        this.place3 = place3;
    }

    public String getPlace4() {
        return place4;
    }

    public void setPlace4(String place4) {
        this.place4 = place4;
    }

    public String getTime1() {
        return time1;
    }

    public void setTime1(String time1) {
        this.time1 = time1;
    }

    public String getTime2() {
        return time2;
    }

    public void setTime2(String time2) {
        this.time2 = time2;
    }

    public String getTime3() {
        return time3;
    }

    public void setTime3(String time3) {
        this.time3 = time3;
    }

    public String getTime4() {
        return time4;
    }

    public void setTime4(String time4) {
        this.time4 = time4;
    }

    public int getMaxSeats() {
        return maxSeats;
    }

    public void setMaxSeats(int maxSeats) {
        this.maxSeats = maxSeats;
    }

    public MovieDetails getMovieDetails() {
        return movieDetails;
    }

    public void setMovieDetails(MovieDetails movieDetails) {
        this.movieDetails = movieDetails;
    }
}
