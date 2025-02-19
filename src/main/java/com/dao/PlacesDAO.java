package com.dao;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.pojo.Places;
import com.util.HibernateUtil;
public class PlacesDAO {
    public void updateMaxSeats(int placeId, int seatsToBook) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Places place = session.get(Places.class, placeId);           
            if (place != null) {
                int updatedMaxSeats = place.getMaxSeats() - seatsToBook;              
                if (updatedMaxSeats >= 0) {  
                    place.setMaxSeats(updatedMaxSeats);
                    session.update(place);
                    transaction.commit();
                } else {throw new RuntimeException("Not enough seats available.");}
            } else {throw new RuntimeException("Place not found.");}
        } catch (Exception e) {if (transaction != null) {transaction.rollback();}
            e.printStackTrace();
        } finally { session.close();}
    }
}
